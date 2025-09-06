document.addEventListener('DOMContentLoaded', function () {
    const modal = document.querySelector('.modal');
    const modalContent = document.querySelector('.modal-content');
    const closeBtn = document.querySelector('.close');
    const quantityInput = document.getElementById('quantity');
    const minusBtn = document.querySelector('.quantity-btn.minus');
    const plusBtn = document.querySelector('.quantity-btn.plus');
    const addToCartBtn = document.querySelector('.action-buttons-cart');
    const buyNowBtn = document.querySelector('.action-buttons-buy');
    const customizationSection = document.querySelector('.customization-section');
    const drinksGrid = document.querySelector('.drinks-grid');

    let currentDrink = null;
    
    // Check if we're on the food page
    const isFood = window.location.pathname.includes('food.html');

    // Function to load products
    async function loadProducts() {
        try {
            const category = isFood ? 'Food' : 'Drinks';
            const response = await fetch(`../PHP/fetch_products.php?category=${category}`);
            const products = await response.json();
            
            // Clear existing grid
            drinksGrid.innerHTML = '';
            
            // Create product elements
            products.forEach(product => {
                const productHTML = `
                    <div class="drink-item">
                        <button class="drink-button" data-product-id="${product.id}">
                            <img src="../Image/${product.image}" alt="${product.name}">
                            <h1>${product.name}</h1>
                            <p>RM${parseFloat(product.price).toFixed(2)}</p>
                        </button>
                    </div>
                `;
                drinksGrid.innerHTML += productHTML;
            });
            
            // Reattach event listeners to new elements
            attachEventListeners();
        } catch (error) {
            console.error('Error loading products:', error);
        }
    }
    
    // Function to attach event listeners to product buttons
    function attachEventListeners() {
        document.querySelectorAll('.drink-button').forEach(button => {
            button.addEventListener('click', function() {
                const name = this.querySelector('h1').textContent;
                const price = parseFloat(this.querySelector('p').textContent.replace('RM', ''));
                const image = this.querySelector('img').src;
                const id = parseInt(this.getAttribute('data-product-id'));

                currentDrink = { 
                    id: id,
                    name: name, 
                    basePrice: price,
                    image: image 
                };

                document.getElementById('modalDrinkName').textContent = name;
                document.getElementById('modalDrinkPrice').textContent = `RM${price.toFixed(2)}`;
                document.getElementById('modalDrinkImage').src = image;
                
                resetModalOptions();
                updateTotalPrice();
                openPopup();
            });
        });
    }

    // Load products when page loads
    loadProducts();

    // If it's the food page, hide customization section
    if (isFood && customizationSection) {
        customizationSection.style.display = 'none';
    }

    // Reset modal options to default values
    function resetModalOptions() {
        quantityInput.value = 1;
        if (!isFood) {
            // Only reset these options for drinks
            document.querySelectorAll('.option-btn').forEach(btn => btn.classList.remove('active'));
            document.querySelector('.variant-btn[data-value="hot"]').classList.add('active');
            document.querySelector('.size-btn[data-value="regular"]').classList.add('active');
            document.querySelector('.sugar-btn[data-value="normal"]').classList.add('active');
            document.querySelector('.ice-btn[data-value="normal"]').classList.add('active');
            updateIceOptions('hot');
        }
    }

    // Handle option button clicks (only for drinks)
    if (!isFood) {
        document.querySelectorAll('.option-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                const siblings = this.parentElement.querySelectorAll('.option-btn');
                siblings.forEach(sibling => sibling.classList.remove('active'));
                this.classList.add('active');

                if (this.classList.contains('variant-btn')) {
                    updateIceOptions(this.dataset.value);
                }

                updateTotalPrice();
            });
        });
    }

    // Function to update ice options based on variant
    function updateIceOptions(variant) {
        const iceOptionGroup = document.querySelector('.option-group:last-child');
        if (iceOptionGroup) {
            if (variant === 'hot') {
                iceOptionGroup.style.display = 'none';
            } else {
                iceOptionGroup.style.display = 'block';
            }
        }
    }

    // Quantity buttons
    minusBtn.addEventListener('click', () => {
        if (parseInt(quantityInput.value) > 1) {
            quantityInput.value = parseInt(quantityInput.value) - 1;
            updateTotalPrice();
        }
    });

    plusBtn.addEventListener('click', () => {
        if (parseInt(quantityInput.value) < 10) {
            quantityInput.value = parseInt(quantityInput.value) + 1;
            updateTotalPrice();
        }
    });

    // Update total price
    function updateTotalPrice() {
        if (!currentDrink) return;
        
        let unitPrice = currentDrink.basePrice;
        if (!isFood) {
            const size = document.querySelector('.size-btn.active')?.dataset.value;
            if (size === 'large') {
                unitPrice += 2;
            }
        }
        const quantity = parseInt(quantityInput.value);
        const totalPrice = unitPrice * quantity;
        document.getElementById('modalTotalPrice').textContent = `RM${totalPrice.toFixed(2)}`;
        
        // Store unit price for cart submission
        currentDrink.currentUnitPrice = unitPrice;
    }

    // Open popup
    function openPopup() {
        modal.classList.add('active');
        modalContent.classList.add('open-popup');
    }

    // Close modal
    function closeModal() {
        modal.classList.remove('active');
        modalContent.classList.remove('open-popup');
    }

    // Event listeners for closing modal
    window.addEventListener('click', (e) => {
        if (e.target === modal) {
            closeModal();
        }
    });

    closeBtn.addEventListener('click', closeModal);

    // Add to cart functionality
    addToCartBtn.addEventListener('click', async () => {
        try {
            if (!currentDrink || !currentDrink.id) {
                alert('Please select an item first');
                return;
            }
    
            const formData = new FormData();
            formData.append('product_id', currentDrink.id);
            formData.append('quantity', quantityInput.value);
            formData.append('price', currentDrink.currentUnitPrice); // Send unit price instead of total
    
            if (!isFood) {
                const variant = document.querySelector('.variant-btn.active').dataset.value;
                const size = document.querySelector('.size-btn.active').dataset.value;
                const sugar = document.querySelector('.sugar-btn.active').dataset.value;
                const ice = variant === 'hot' ? 'none' : document.querySelector('.ice-btn.active').dataset.value;
    
                formData.append('variant', variant);
                formData.append('size', size);
                formData.append('sugar', sugar);
                formData.append('ice', ice);
            } else {
                formData.append('variant', 'none');
                formData.append('size', 'none');
                formData.append('sugar', 'none');
                formData.append('ice', 'none');
            }
    
            const response = await fetch('../PHP/add_to_cart.php', {
                method: 'POST',
                body: formData
            });
            
            const result = await response.text();
            
            if (result === 'success') {
                alert('Added to cart successfully!');
                closeModal();
            } else if (result === 'login_required') {
                alert('Please login first');
                window.location.href = '../html/login.html';
            } else {
                alert(result || 'Error adding to cart');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Error: ' + error.message);
        }
    });

    // Buy Now functionality
    buyNowBtn.addEventListener('click', () => {
        // Add your buy now logic here
        console.log('Buy Now clicked');
        // You could redirect to a checkout page or handle the purchase directly
    });
});