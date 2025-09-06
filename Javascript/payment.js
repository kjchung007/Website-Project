document.addEventListener('DOMContentLoaded', function () {
    // Load cart data and user details
    fetch('../PHP/payment.php')
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            // Populate user details
            if (data.user) {
                document.querySelector('input[name="name"]').value = data.user.name;
                document.querySelector('input[name="email"]').value = data.user.email;
            }

            // Populate cart items with precise calculations
            const cartItemsContainer = document.querySelector('.cart-items');
            cartItemsContainer.innerHTML = '';
            
            let calculatedSubtotal = 0;

            data.cart_items.forEach(item => {
                let itemPrice = parseFloat(item.unit_price || 0) * parseInt(item.quantity || 0);

                // Add RM2 for large drinks
                if (item.size && item.size.toLowerCase() === 'large') {
                    itemPrice += 2 * parseInt(item.quantity || 0);
                }
                calculatedSubtotal += itemPrice;
            
                const itemElement = document.createElement('div');
                itemElement.className = 'cart-item';
                itemElement.innerHTML = `
                    <div class="item-image">
                        <img src="../Image/${item.product_image || 'default.png'}" alt="${item.product_name || 'Product'}">
                    </div>
                    <div class="item-details">
                        <p class="item-title">${item.product_name || 'Unknown Product'}</p>
                        <p class="item-size">Size: ${item.size ? item.size.charAt(0).toUpperCase() + item.size.slice(1) : 'Regular'}</p>
                        <p class="item-price">Total: RM${itemPrice.toFixed(2)}</p>
                        <p class="item-quantity">Quantity: ${item.quantity || 1}</p>
                        <p class="item-unit-price">Unit Price: RM${parseFloat(item.unit_price || 0).toFixed(2)}</p>
                    </div>
                `;
                cartItemsContainer.appendChild(itemElement);
            });

            // Update totals with precise calculations
            document.querySelector('.total-row:nth-child(1) span:last-child').textContent = 
                `RM${calculatedSubtotal.toFixed(2)}`;
            const discount = parseFloat(data.totals.discount || 0);
            document.querySelector('.total-row:nth-child(2) span:last-child').textContent = 
                `RM${discount.toFixed(2)}`;
            const finalTotal = calculatedSubtotal - discount;
            document.querySelector('.total-row.total-final span:last-child').textContent = 
                `RM${finalTotal.toFixed(2)}`;
        })
        .catch(error => {
            console.error('Error fetching cart data:', error);
            alert('Error loading cart: ' + error.message);
        });

    // Handle form submission with improved error handling
    document.getElementById('paymentForm').addEventListener('submit', function (e) {
        e.preventDefault();

        if (!validateForm()) {
            return;
        }

        const formData = new FormData(this);
        formData.append('action', 'payment');

        // Show loading state
        const submitButton = this.querySelector('button[type="submit"]');
        const originalButtonText = submitButton.textContent;
        submitButton.disabled = true;
        submitButton.textContent = 'Processing...';

        fetch('../PHP/payment.php', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Backend Response:', data);
            if (data.success) {
                alert('Payment successful! Thank you for your purchase. Your order will be processed shortly');
                window.location.href = '../html/home.html';
            } else {
                throw new Error(data.error || 'Payment failed. Please try again.');
            }
        })
        .catch(error => {
            console.error('Error processing payment:', error);
            alert('Payment Error: ' + error.message);
        })
        .finally(() => {
            // Reset button state
            submitButton.disabled = false;
            submitButton.textContent = originalButtonText;
        });
    });
});

// Enhanced form validation
function validateForm() {
    const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked')?.value;
    if (!paymentMethod) {
        alert('Please select a payment method');
        return false;
    }

    const required = ['name', 'email', 'phone', 'pickupLocation'];
    const fieldLabels = {
        name: 'Full Name',
        email: 'Email Address',
        phone: 'Phone Number',
        pickupLocation: 'Pickup Location',
        bankName: 'Bank Name',
        accountNumber: 'Account Number',
        cardholderName: 'Cardholder Name',
        cardNumber: 'Card Number',
        expDate: 'Expiration Date',
        cvc: 'CVC'
    };

    if (paymentMethod === 'banking') {
        required.push('bankName', 'accountNumber');
    } else {
        required.push('cardholderName', 'cardNumber', 'expDate', 'cvc');
    }

    for (const field of required) {
        const input = document.querySelector(`[name="${field}"]`);
        if (!input || !input.value.trim()) {
            alert(`Please fill in ${fieldLabels[field]}`);
            input?.focus();
            return false;
        }
    }

    return true;
}
