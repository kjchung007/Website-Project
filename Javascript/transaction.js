// Global transactions variable
let transactions = [];

// Fetch transactions
async function fetchTransactions() {
    try {
        console.log('Fetching transactions...');
        const response = await fetch('../PHP/transaction.php');
        console.log('Response status:', response.status);
        
        const data = await response.json();
        console.log('Response data:', data);

        if (!data.success) {
            throw new Error(data.error || 'Failed to load transactions');
        }

        // Store transactions globally
        transactions = data.data;
        const activeTimeFrame = document.querySelector('.time-filter button.active-filter')?.id?.replace('Btn', '') || 'daily';
        filterByTime(activeTimeFrame);
    } catch (error) {
        console.error('Error details:', error);
        document.getElementById('transactionBody').innerHTML = `
            <tr>
                <td colspan="7" class="error">Error loading transactions: ${error.message}</td>
            </tr>
        `;
    }
}

// Format date
function formatDate(dateString) {
    try {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-GB', { 
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
        });
    } catch (error) {
        console.error('Date formatting error:', error);
        return dateString;
    }
}

// Week utilities
function getStartOfWeek(date) {
    const newDate = new Date(date);
    const day = newDate.getDay();
    const diff = newDate.getDate() - day + (day === 0 ? -6 : 1); // Adjust for Sunday
    newDate.setDate(diff);
    newDate.setHours(0, 0, 0, 0);
    return newDate;
}

function getEndOfWeek(date) {
    const newDate = new Date(date);
    const day = newDate.getDay();
    const diff = newDate.getDate() + (day === 0 ? 0 : 7 - day);
    newDate.setDate(diff);
    newDate.setHours(23, 59, 59, 999);
    return newDate;
}

// Update date range display
function updateDateRangeDisplay(timeFrame) {
    const selectedDate = new Date(document.getElementById('datePicker').value);
    let displayText = '';

    switch (timeFrame) {
        case 'daily':
            displayText = formatDisplayDate(selectedDate);
            break;
        case 'weekly':
            const weekStart = getStartOfWeek(selectedDate);
            const weekEnd = getEndOfWeek(selectedDate);
            displayText = `${formatDisplayDate(weekStart)} - ${formatDisplayDate(weekEnd)}`;
            break;
        case 'monthly':
            displayText = selectedDate.toLocaleString('default', { month: 'long', year: 'numeric' });
            break;
    }

    let displayElement = document.querySelector('.date-range-display');
    if (!displayElement) {
        displayElement = document.createElement('div');
        displayElement.className = 'date-range-display';
        document.querySelector('.date-navigation').insertAdjacentElement('afterend', displayElement);
    }
    displayElement.textContent = displayText;
}

function formatDisplayDate(date) {
    return date.toLocaleDateString('en-GB', {  // Changed from en-MY to en-GB
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
    });
}

// Filter transactions
function filterByTime(timeFrame) {
    document.querySelectorAll('.time-filter button').forEach((btn) => btn.classList.remove('active-filter'));
    document.getElementById(`${timeFrame}Btn`).classList.add('active-filter');

    const selectedDate = new Date(document.getElementById('datePicker').value);
    let filteredTransactions = [];

    switch (timeFrame) {
        case 'daily':
            filteredTransactions = transactions.filter((transaction) => {
                const txDate = new Date(transaction.date);
                return txDate.toDateString() === selectedDate.toDateString();
            });
            break;
        case 'weekly':
            const weekStart = getStartOfWeek(selectedDate);
            const weekEnd = getEndOfWeek(selectedDate);
            filteredTransactions = transactions.filter((transaction) => {
                const txDate = new Date(transaction.date);
                return txDate >= weekStart && txDate <= weekEnd;
            });
            break;
        case 'monthly':
            filteredTransactions = transactions.filter((transaction) => {
                const txDate = new Date(transaction.date);
                return txDate.getMonth() === selectedDate.getMonth() && txDate.getFullYear() === selectedDate.getFullYear();
            });
            break;
    }

    updateDateRangeDisplay(timeFrame);
    displayTransactions(filteredTransactions);
}

// Display transactions
function displayTransactions(transactionsToShow = transactions) {
    const tbody = document.getElementById('transactionBody');
    tbody.innerHTML = '';

    if (!transactionsToShow || transactionsToShow.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="7">No transactions found</td>
            </tr>
        `;
        return;
    }

    transactionsToShow.forEach((transaction) => {
        const row = document.createElement('tr');
        row.onclick = () => showTransactionDetails(transaction);
        row.innerHTML = `
            <td>${transaction.id}</td>
            <td>${formatDate(transaction.date)}</td>
            <td>${transaction.customer}</td>
            <td>${transaction.items.map((item) => item.name).join(', ')}</td>
            <td>RM ${transaction.total.toFixed(2)}</td>
            <td>${transaction.paymentMethod}</td>
            <td class="status-${transaction.status.toLowerCase()}">${transaction.status}</td>
        `;
        tbody.appendChild(row);
    });
}

// Navigate dates
function navigateDate(direction) {
    const datePicker = document.getElementById('datePicker');
    const currentDate = new Date(datePicker.value);
    const activeTimeFrame = document.querySelector('.time-filter button.active-filter')?.id?.replace('Btn', '') || 'daily';

    switch (activeTimeFrame) {
        case 'daily':
            currentDate.setDate(currentDate.getDate() + (direction === 'next' ? 1 : -1));
            break;
        case 'weekly':
            currentDate.setDate(currentDate.getDate() + (direction === 'next' ? 7 : -7));
            break;
        case 'monthly':
            currentDate.setMonth(currentDate.getMonth() + (direction === 'next' ? 1 : -1));
            break;
    }

    datePicker.valueAsDate = currentDate;
    filterByTime(activeTimeFrame);
    updateDateRangeDisplay(activeTimeFrame);
}

// Show transaction details
function showTransactionDetails(transaction) {
    document.getElementById('modalTrxId').textContent = transaction.id;
    document.getElementById('modalDate').textContent = formatDate(transaction.date);
    document.getElementById('modalTotal').textContent = `RM ${transaction.total.toFixed(2)}`;
    document.getElementById('modalPayment').textContent = transaction.paymentMethod;
    document.getElementById('modalStatus').textContent = transaction.status;

    document.getElementById('modalCustomerName').textContent = transaction.customer;
    document.getElementById('modalCustomerEmail').textContent = transaction.customerEmail;

    const modalItems = document.getElementById('modalItems');
    modalItems.innerHTML = '';
    transaction.items.forEach((item) => {
        const itemCard = document.createElement('div');
        itemCard.className = 'item-card';
        itemCard.innerHTML = `
            <h4>${item.name}</h4>
            <div class="item-customization">${item.customization}</div>
        `;
        modalItems.appendChild(itemCard);
    });

    document.getElementById('transactionModal').style.display = 'block';
}

function searchTransactions() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    
    const filteredTransactions = transactions.filter(transaction => 
        transaction.id.toLowerCase().includes(searchTerm) ||
        transaction.customer.toLowerCase().includes(searchTerm)
    );

    displayTransactions(filteredTransactions);
}


// Initialize on DOM load
document.addEventListener('DOMContentLoaded', () => {
    const datePicker = document.getElementById('datePicker');
    const today = new Date();
    datePicker.value = today.toISOString().split('T')[0];  // Keep YYYY-MM-DD for input value
    
    datePicker.addEventListener('change', () => {
        const activeTimeFrame = document.querySelector('.time-filter button.active-filter')?.id?.replace('Btn', '') || 'daily';
        filterByTime(activeTimeFrame);
    });

    fetchTransactions().then(() => {
        document.getElementById('dailyBtn').classList.add('active-filter');
        filterByTime('daily');
    });

    // Add this to your JavaScript
    document.querySelector('.close').addEventListener('click', () => {
    document.getElementById('transactionModal').style.display = 'none';
    });
});

// Add these event listeners after your DOMContentLoaded event

// Close modal when clicking outside
window.addEventListener('click', (event) => {
    const modal = document.getElementById('transactionModal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
});

// Close modal when clicking cancel button
document.querySelector('.modal-close').addEventListener('click', () => {
    document.getElementById('transactionModal').style.display = 'none';
});

// Add event listener for enter key in search input
document.getElementById('searchInput').addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        searchTransactions();
    }
});
