// cart.js
class CartManager {
    constructor() {
        this.cartItems = [];
        this.initializeCart();
        this.bindEvents();
    }

    async initializeCart() {
        try {
            console.log('Initializing cart...');
            const response = await fetch('../PHP/cart.php');
            console.log('Response status:', response.status);
            
            if (!response.ok) {
                console.error('Response not OK:', response.status, response.statusText);
                if (response.status === 401) {
                    window.location.href = 'login.html';
                    return;
                }
                throw new Error(`Network response was not ok: ${response.status}`);
            }
            
            const text = await response.text();
            console.log('Raw response text:', text);
            
            const data = JSON.parse(text);
            console.log('Parsed cart data:', data);
            
            if (!data.items || !Array.isArray(data.items)) {
                console.error('Invalid items data:', data);
                throw new Error('Invalid cart data structure');
            }
            
            this.cartItems = data.items;
            console.log('Updated cart items:', this.cartItems);
            this.updateCartDisplay(data);
            this.updateTotals(data); // Update the totals display
        } catch (error) {
            console.error('Cart initialization error:', error);
            this.showError('Failed to load cart items');
        }
    }
    
    updateCartDisplay(data) {
        console.log('Updating display with data:', data);
        const cartContainer = document.querySelector('.cart-container');
        const emptyMessage = document.getElementById('emptyCartMessage');
        const cartItemsContainer = document.getElementById('cartItems');
    
        if (!data.items || data.items.length === 0) {
            console.log('No items to display');
            cartContainer.style.display = 'none';
            emptyMessage.style.display = 'block';
            return;
        }
    
        console.log('Displaying items:', data.items);
        cartContainer.style.display = 'flex';
        emptyMessage.style.display = 'none';
        
        const html = data.items.map(item => {
            console.log('Creating HTML for item:', item);
            return this.createCartItemHTML(item);
        }).join('');
        
        console.log('Final HTML:', html);
        cartItemsContainer.innerHTML = html;
        
        // Update totals after displaying items
        this.updateTotals(data);
    }

    updateTotals(data) {
        // Update the totals in the cart summary
        const subtotalElement = document.getElementById('subtotal');
        const discountElement = document.getElementById('discount');
        const totalElement = document.getElementById('total');

        if (subtotalElement) {
            subtotalElement.textContent = `$${data.subtotal.toFixed(2)}`;
        }
        if (discountElement) {
            discountElement.textContent = `$${data.discount.toFixed(2)}`;
        }
        if (totalElement) {
            totalElement.textContent = `$${data.total.toFixed(2)}`;
        }
    }

    async updateQuantity(cartId, newQuantity) {
        // Validate quantity
        newQuantity = parseInt(newQuantity);
        if (isNaN(newQuantity) || newQuantity < 1 || newQuantity > 10) {
            this.showError('Quantity must be between 1 and 10');
            this.initializeCart(); // Reset display to previous state
            return;
        }

        try {
            const formData = new FormData();
            formData.append('action', 'update');
            formData.append('cart_id', cartId);
            formData.append('quantity', newQuantity);

            const response = await fetch('../PHP/cart.php', {
                method: 'POST',
                body: formData
            });

            const responseText = await response.text();
            let data;
            try {
                data = JSON.parse(responseText);
            } catch (e) {
                console.error('Failed to parse response:', responseText);
                throw new Error('Invalid server response');
            }

            if (!data.success) {
                throw new Error(data.error || 'Failed to update quantity');
            }

            // Refresh the cart to show updated totals
            await this.initializeCart();
            this.showSuccess('Quantity updated successfully');
        } catch (error) {
            console.error('Error updating quantity:', error);
            this.showError(error.message);
            await this.initializeCart(); // Reset display to previous state
        }
    }

    createCartItemHTML(item) {
        return `
            <div class="cart-item" data-id="${item.id}">
                <img class="item-image" src="${item.product_image}" alt="${item.product_name}">
                <div class="item-details">
                    <h3>${item.product_name}</h3>
                    <p>Variant: ${item.variant}</p>
                    <p>Size: ${item.size}</p>
                    <p>Sugar: ${item.sugar}</p>
                    ${item.variant === 'Iced' ? `<p>Ice: ${item.ice}</p>` : ''}
                    <div class="quantity-controls">
                        <button onclick="cart.updateQuantity(${item.id}, ${Math.max(1, parseInt(item.quantity) - 1)})" class="quantity-btn">-</button>
                        <input type="number" value="${item.quantity}" min="1" max="10" 
                               onchange="cart.updateQuantity(${item.id}, this.value)"
                               onkeypress="return event.charCode >= 48 && event.charCode <= 57">
                        <button onclick="cart.updateQuantity(${item.id}, ${Math.min(10, parseInt(item.quantity) + 1)})" class="quantity-btn">+</button>
                        <button onclick="cart.removeItem(${item.id})" class="remove-btn">Remove</button>
                    </div>
                    <p class="price">$${(item.price * item.quantity).toFixed(2)}</p>
                </div>
            </div>
        `;
    }

    async removeItem(cartId) {
        try {
            console.log('Removing item:', cartId);
            const formData = new FormData();
            formData.append('action', 'remove');
            formData.append('cart_id', cartId);
    
            const response = await fetch('../PHP/cart.php', {
                method: 'POST',
                body: formData
            });
    
            const responseText = await response.text();
            console.log('Remove response:', responseText);
    
            let result;
            try {
                result = JSON.parse(responseText);
            } catch (e) {
                console.error('Parse error:', e);
                throw new Error('Invalid response format');
            }
    
            if (result.success) {
                console.log('Remove successful:', result);
                // Force a complete refresh of cart data
                await new Promise(resolve => setTimeout(resolve, 100)); // Small delay
                await this.initializeCart();
                this.showSuccess('Item removed successfully');
            } else {
                throw new Error(result.error || 'Remove failed');
            }
        } catch (error) {
            console.error('Remove error:', error);
            this.showError(`Remove failed: ${error.message}`);
        }
    }
    
    showSuccess(message) {
        alert(message);
    }

    showError(message) {
        alert(message);
    }

    bindEvents() {
        const checkoutBtn = document.querySelector('.checkout-btn');
        if (checkoutBtn) {
            checkoutBtn.addEventListener('click', () => this.handleCheckout());
        }

        // Add voucher application handling
        const applyBtn = document.querySelector('.apply-btn');
        if (applyBtn) {
            applyBtn.addEventListener('click', () => this.applyVoucher());
        }
    }

    async applyVoucher() {
        const voucherInput = document.querySelector('.voucher-input');
        const voucherCode = voucherInput.value.trim();
        
        if (!voucherCode) {
            this.showError('Please enter a voucher code');
            return;
        }

        try {
            const formData = new FormData();
            formData.append('action', 'apply_voucher');
            formData.append('voucher_code', voucherCode);

            const response = await fetch('../PHP/cart.php', {
                method: 'POST',
                body: formData
            });

            const data = await response.json();
            
            if (data.success) {
                this.showSuccess('Voucher applied successfully');
                await this.initializeCart(); // Refresh cart to show updated totals
            } else {
                this.showError(data.error || 'Failed to apply voucher');
            }
        } catch (error) {
            console.error('Error applying voucher:', error);
            this.showError('Failed to apply voucher');
        }
    }

    handleCheckout() {
        window.location.href = 'payment.html';
    }
}

// Initialize cart manager
const cart = new CartManager();