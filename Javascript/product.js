document.addEventListener('DOMContentLoaded', function() {
    // Get all menu tabs and items
    const menuTabs = document.querySelectorAll('.menu-tab');
    const menuItems = document.querySelectorAll('.drink-item, .add-product');
    
    // Function to filter items
    function filterItems(category) {
        menuItems.forEach(item => {
            // Normalize case for comparison
            const itemCategory = item.dataset.category.toLowerCase();
            const targetCategory = category.toLowerCase();
            item.style.display = itemCategory === targetCategory ? 'flex' : 'none';
        });
    }
    
    // Add click event listeners to tabs
    menuTabs.forEach(tab => {
        tab.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Remove active class from all tabs
            menuTabs.forEach(t => t.classList.remove('active'));
            
            // Add active class to clicked tab
            this.classList.add('active');
            
            // Filter items based on category
            const category = this.dataset.category;
            filterItems(category);
        });
    });
    
    // Show drinks by default
    filterItems('Drinks'); // Ensure the case matches the data attribute
});


// Variable to store current product item being edited
let currentEditingItem = null;

// Modal functionality
function openModal(element) {
    const modal = document.getElementById('editModal');
    const modalImage = document.getElementById('modalProductImage');
    const modalName = document.getElementById('modalProductName');
    const modalPrice = document.getElementById('modalProductPrice');
    const productNameInput = document.getElementById('productName');
    
    // Get product details from the clicked item
    const productItem = element.closest('.drink-item');
    currentEditingItem = productItem;
    
    const productImage = productItem.querySelector('img').src;
    const productName = productItem.querySelector('h1').textContent;
    const productPrice = productItem.querySelector('.price-container p').textContent;
    
    // Set modal content
    modalImage.src = productImage;
    modalName.textContent = productName;
    modalPrice.textContent = productPrice;
    productNameInput.value = productName;
    
    // Set price input
    const priceValue = productPrice.replace('RM ', '');
    document.getElementById('productPrice').value = parseFloat(priceValue);
    
    modal.style.display = 'block';
    // Trigger reflow
    modal.offsetHeight;
    modal.classList.add('show');
}

function closeModal() {
    const modal = document.getElementById('editModal');
    modal.classList.remove('show');
    setTimeout(() => {
        modal.style.display = 'none';
        currentEditingItem = null;
    }, 300); // Match the transition duration
}

function deleteProduct() {
    if (currentEditingItem && confirm('Are you sure you want to delete this product?')) {
        currentEditingItem.remove(); // Remove the item from the DOM
        closeModal();
    }
}

// Close modal when clicking outside
window.addEventListener('click', function(e) {
    const modal = document.getElementById('editModal');
    if (e.target === modal) {
        closeModal();
    }
});

// Handle form submission
document.getElementById('editProductForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    if (currentEditingItem) {
        const newName = document.getElementById('productName').value;
        const newPrice = document.getElementById('productPrice').value;
        
        const formData = new FormData();
        formData.append('action', 'update');
        formData.append('name', newName);
        formData.append('price', newPrice);
        formData.append('category', currentEditingItem.dataset.category);
        formData.append('image', currentEditingItem.querySelector('img').src.split('/').pop());
        formData.append('originalName', currentEditingItem.querySelector('h1').textContent);

        try {
            const response = await fetch('../PHP/manage-product.php', {
                method: 'POST',
                body: formData
            });

            const result = await response.json();
            
            if (result.success) {
                currentEditingItem.querySelector('h1').textContent = newName;
                currentEditingItem.querySelector('.price-container p').textContent = `RM ${newPrice}`;
                closeModal();
            } else {
                alert('Failed to update product: ' + result.message);
            }
        } catch (error) {
            console.error('Error:', error);
            alert('An error occurred while updating the product');
        }
    }
});

// Modify delete function to handle database deletion
async function deleteProduct() {
    if (currentEditingItem && confirm('Are you sure you want to delete this product?')) {
        const formData = new FormData();
        formData.append('action', 'delete');
        formData.append('name', currentEditingItem.querySelector('h1').textContent);
        formData.append('originalName', currentEditingItem.querySelector('h1').textContent);
        
        try {
            const response = await fetch('../PHP/manage-product.php', {
                method: 'POST',
                body: formData
            });

            const result = await response.json();
            
            if (result.success) {
                currentEditingItem.remove();
                closeModal();
            } else {
                alert('Failed to delete product: ' + result.message);
            }
        } catch (error) {
            console.error('Error:', error);
            alert('An error occurred while deleting the product');
        }
    }
}

// Add click handler for add product icons
document.querySelectorAll('.add-product').forEach(btn => {
    btn.addEventListener('click', function() {
        const modal = document.getElementById('addProductModal');
        const category = this.dataset.category;
        document.getElementById('newProductCategory').value = category;
        modal.style.display = 'block';
    });
});

// Close add product modal
document.getElementById('cancelAddProduct').addEventListener('click', function() {
    document.getElementById('addProductModal').style.display = 'none';
});

// Handle new product form submission
document.getElementById('addProductForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    
    const formData = new FormData();
    formData.append('action', 'create');
    formData.append('name', document.getElementById('newProductName').value);
    formData.append('price', document.getElementById('newProductPrice').value);
    formData.append('category', document.getElementById('newProductCategory').value);
    
    const imageFile = document.getElementById('newProductImage').files[0];
    formData.append('image', imageFile);

    try {
        const response = await fetch('../PHP/manage-product.php', {
            method: 'POST',
            body: formData
        });

        const result = await response.json();
        
        if (result.success) {
            // Create new product element
            const newProduct = document.createElement('div');
            newProduct.className = 'drink-item';
            newProduct.dataset.category = result.data.category;
            
            newProduct.innerHTML = `
                <img src="../Image/${result.data.image}" alt="${result.data.name}">
                <h1>${result.data.name}</h1>
                <div class="price-container">
                    <p>RM ${parseFloat(result.data.price).toFixed(2)}</p>
                    <i class="fa-solid fa-sliders" onclick="openModal(this)"></i>
                </div>
            `;

            // Insert before the add button
            const addButton = document.querySelector(`.add-product[data-category="${result.data.category}"]`);
            addButton.parentNode.insertBefore(newProduct, addButton);
            
            // Close modal and reset form
            document.getElementById('addProductModal').style.display = 'none';
            document.getElementById('addProductForm').reset();
        } else {
            alert('Failed to add product: ' + result.message);
        }
    } catch (error) {
        console.error('Error:', error);
        alert('An error occurred while adding the product');
    }
});

function closeAddModal() {
    const modal = document.getElementById('addProductModal');
    document.getElementById('addProductForm').reset();
    modal.style.display = 'none';
}

window.addEventListener('click', function(e) {
    const modal = document.getElementById('addProductModal');
    if (e.target === modal) {
        closeAddModal();
    }
});

// Add click handler for add product icons
document.querySelectorAll('.add-product').forEach(btn => {
    btn.addEventListener('click', function() {
        const modal = document.getElementById('addProductModal');
        const category = this.dataset.category;
        document.getElementById('newProductCategory').value = category;
        modal.style.display = 'block';
        modal.style.opacity = '1';
        modal.style.visibility = 'visible';
        setTimeout(() => {
            modal.classList.add('show');
        }, 10);
    });
});