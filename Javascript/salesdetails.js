// Global variables
let filterMenuVisible = false;

// Fetch and display sales data when the page loads
document.addEventListener('DOMContentLoaded', function() {
    loadSalesData();
    setupEventListeners();
});

// Function to load initial sales data
function loadSalesData() {
    console.log('Fetching sales data...');
    fetch('../PHP/salesdetails.php')
        .then(response => {
            console.log('Response status:', response.status);
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Received data:', data);
            if (Array.isArray(data) && data.length > 0) {
                renderSalesTable(data);
            } else {
                document.getElementById('salesTableBody').innerHTML = '<tr><td colspan="8">No sales data available</td></tr>';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('salesTableBody').innerHTML = 
                `<tr><td colspan="8">Error loading sales data: ${error.message}</td></tr>`;
        });
}

// Function to render the sales table
function renderSalesTable(data) {
    console.log('Rendering table with data:', data);
    const tableBody = document.getElementById('salesTableBody');
    let html = '';
    
    data.forEach(order => {
        if (!order.items || !Array.isArray(order.items)) {
            console.error('Invalid order structure:', order);
            return;
        }

        order.items.forEach((item, index) => {
            html += `
                <tr class="order-group">
                    ${index === 0 ? `
                        <td>${order.order_id}</td>
                        <td>${new Date(order.order_date).toLocaleString()}</td>
                        <td>${order.customer_name}</td>
                    ` : `
                        <td></td>
                        <td></td>
                        <td></td>
                    `}
                    <td>${item.product_name}</td>
                    <td>${item.quantity}</td>
                    <td>RM${parseFloat(item.unit_price).toFixed(2)}</td>
                    <td>RM${parseFloat(item.item_total).toFixed(2)}</td>
                    ${index === 0 ? `
                        <td rowspan="${order.items.length}" class="order-total">
                            RM${parseFloat(order.order_total).toFixed(2)}
                        </td>
                    ` : ''}
                </tr>
            `;
        });
    });
    
    if (html === '') {
        html = '<tr><td colspan="8">No sales data available</td></tr>';
    }
    
    tableBody.innerHTML = html;
}

// Function to toggle filter menu
function toggleFilterMenu() {
    const menu = document.getElementById('filterMenu');
    filterMenuVisible = !filterMenuVisible;
    menu.style.display = filterMenuVisible ? 'block' : 'none';
}

// Function to sort table
function sortTable(criteria) {
    const table = document.querySelector('.sales-table table');
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    
    // Group rows by order ID
    const orderGroups = {};
    rows.forEach(row => {
        const orderId = row.cells[0].textContent.trim();
        if (orderId) {
            if (!orderGroups[orderId]) {
                orderGroups[orderId] = [];
            }
            // Get all rows for this order
            let currentRow = row;
            const orderRows = [currentRow];
            while (currentRow.nextElementSibling && !currentRow.nextElementSibling.cells[0].textContent.trim()) {
                currentRow = currentRow.nextElementSibling;
                orderRows.push(currentRow);
            }
            orderGroups[orderId] = orderRows;
        }
    });

    // Sort the groups based on selected criteria
    const sortedGroups = Object.entries(orderGroups).sort((a, b) => {
        const firstRowA = a[1][0];
        const firstRowB = b[1][0];

        switch(criteria) {
            case 'orderId':
                return firstRowA.cells[0].textContent.localeCompare(firstRowB.cells[0].textContent);
            case 'date':
                return new Date(firstRowA.cells[1].textContent) - new Date(firstRowB.cells[1].textContent);
            case 'name':
                return firstRowA.cells[2].textContent.localeCompare(firstRowB.cells[2].textContent);
            case 'total':
                const totalA = parseFloat(a[1][0].querySelector('.order-total').textContent.replace('RM', ''));
                const totalB = parseFloat(b[1][0].querySelector('.order-total').textContent.replace('RM', ''));
                return totalA - totalB;
        }
    });

    // Clear the table
    tbody.innerHTML = '';

    // Rebuild the table with sorted groups
    sortedGroups.forEach(([_, groupRows]) => {
        groupRows.forEach((row, index) => {
            const newRow = row.cloneNode(true);
            if (index === 0) {
                const totalCell = newRow.querySelector('.order-total');
                if (totalCell) {
                    totalCell.setAttribute('rowspan', groupRows.length);
                }
            }
            tbody.appendChild(newRow);
        });
    });

    // Close the filter menu after selection
    toggleFilterMenu();
}

// Setup event listeners
function setupEventListeners() {
    // Close filter menu when clicking outside
    document.addEventListener('click', function(event) {
        const filterIcon = document.querySelector('.filter-icon');
        if (!filterIcon.contains(event.target) && filterMenuVisible) {
            toggleFilterMenu();
        }
    });
}