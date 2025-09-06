document.addEventListener('DOMContentLoaded', function() {
    loadOrders();
    
    // Update active navigation based on current page
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.profile-nav a');

    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
});

function loadOrders() {
    fetch('../PHP/orders.php')
        .then(response => response.json())
        .then(data => {
            if (data.error === 'login_required') {
                window.location.href = 'login.html';
                return;
            }
            
            if (data.success && data.orders) {
                displayOrders(data.orders);
            }
        })
        .catch(error => console.error('Error loading orders:', error));
}

function displayOrders(orders) {
    const ordersList = document.getElementById('ordersList');
    ordersList.innerHTML = '';

    orders.forEach(order => {
        const orderCard = createOrderCard(order);
        ordersList.appendChild(orderCard);
    });
}

function createOrderCard(order) {
    const orderCard = document.createElement('div');
    orderCard.className = 'order-card';
    
    // Construct the image path
    const imagePath = `../Image/${order.product_image}`;
    
    orderCard.innerHTML = `
        <div class="order-details">
            <img src="${imagePath}" alt="${order.product_name}" class="order-logo">
            <div class="order-info">
                <h3>${order.product_name}</h3>
                <p class="order-total">Total: <span>RM${parseFloat(order.price).toFixed(2)}</span></p>
                <p class="order-variants">
                    ${order.variant} | ${order.size} | Sugar: ${order.sugar} | Ice: ${order.ice}
                </p>
            </div>
            <div class="order-status">
                <p class="order-date">ORDERED ON ${new Date(order.created_at).toLocaleDateString()}</p>
                <p class="order-points">+${Math.floor(order.price)} Points</p>
                <div class="button-group">
                    <button class="receipt-btn" data-order-id="${order.id}">
                        <i class="fas fa-receipt"></i> Receipt
                    </button>
                    <button class="reorder-btn" data-order="${encodeURIComponent(JSON.stringify(order))}">
                        Reorder
                    </button>
                </div>
            </div>
        </div>
    `;

    // Add event listener for reorder button
    const reorderBtn = orderCard.querySelector('.reorder-btn');
    reorderBtn.addEventListener('click', function() {
        const orderData = JSON.parse(decodeURIComponent(this.dataset.order));
        reorderItem(orderData);
    });

    // Update receipt button click handler
    const receiptBtn = orderCard.querySelector('.receipt-btn');
    receiptBtn.addEventListener('click', function() {
        loadReceipt(order.id);
    });

    return orderCard;
}

function loadReceipt(orderId) {
    fetch(`../PHP/get_receipt.php?order_id=${orderId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                displayReceipt(data.order);
            } else {
                alert('Failed to load receipt: ' + data.error);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while loading the receipt');
        });
}

function displayReceipt(order) {
    // Fill in receipt details
    document.getElementById('receiptOrderId').textContent = order.id;
    document.getElementById('receiptDate').textContent = order.date;
    document.getElementById('receiptCustomer').textContent = order.customer;
    document.getElementById('receiptEmail').textContent = order.email;
    document.getElementById('receiptProduct').textContent = order.product_name;
    document.getElementById('receiptVariant').textContent = order.variant;
    document.getElementById('receiptSize').textContent = order.size;
    document.getElementById('receiptSugar').textContent = order.sugar;
    document.getElementById('receiptIce').textContent = order.ice;
    document.getElementById('receiptQuantity').textContent = order.quantity;
    document.getElementById('receiptTotal').textContent = order.price;

    // Show the modal by removing hidden class
    const modal = document.getElementById('receiptModal');
    modal.classList.remove('hidden');
}

// Update modal close handler
document.querySelector('.close').addEventListener('click', function() {
    document.getElementById('receiptModal').classList.add('hidden');
});

// Update window click handler
window.addEventListener('click', function(event) {
    const modal = document.getElementById('receiptModal');
    if (event.target === modal) {
        modal.classList.add('hidden');
    }
});

function reorderItem(orderData) {
    const formData = new FormData();
    formData.append('product_id', orderData.product_id);
    formData.append('quantity', orderData.quantity);
    formData.append('price', orderData.price);
    formData.append('variant', orderData.variant);
    formData.append('size', orderData.size);
    formData.append('sugar', orderData.sugar);
    formData.append('ice', orderData.ice);

    fetch('../PHP/add_to_cart.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(result => {
        if (result === 'success') {
            alert('Item added to cart!');
        } else if (result === 'login_required') {
            window.location.href = 'login.html';
        } else {
            alert('Failed to add item to cart: ' + result);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while adding item to cart');
    });
}


/* this was suppose to be validation receipt for phone number if no need can delete le

// Modal handling code
document.querySelector('.close').addEventListener('click', function() {
    document.getElementById('receiptModal').style.display = 'none';
    document.getElementById('modalMessage').textContent = '';
});

window.addEventListener('click', function(event) {
    const modal = document.getElementById('receiptModal');
    if (event.target === modal) {
        modal.style.display = 'none';
        document.getElementById('modalMessage').textContent = '';
    }
});

document.getElementById('sendReceiptBtn').addEventListener('click', function() {
    const phoneNumber = document.getElementById('phoneNumber').value;
    const messageElement = document.getElementById('modalMessage');
    
    // Basic phone number validation
    if (!phoneNumber.match(/^[0-9]{10,11}$/)) {
        messageElement.textContent = 'Please enter a valid phone number';
        messageElement.style.color = 'red';
        return;
    }

    // Get order details from modal dataset
    const orderDetails = JSON.parse(document.getElementById('receiptModal').dataset.orderInfo);
    
    // Simulate sending receipt (replace with actual API call)
    messageElement.textContent = 'Sending receipt...';
    messageElement.style.color = 'blue';
    
    // Simulate API call
    setTimeout(() => {
        messageElement.textContent = 'Receipt sent successfully!';
        messageElement.style.color = 'green';
        
        // Close modal after success
        setTimeout(() => {
            document.getElementById('receiptModal').style.display = 'none';
            document.getElementById('phoneNumber').value = '';
            messageElement.textContent = '';
        }, 2000);
    }, 1500);
});
*/