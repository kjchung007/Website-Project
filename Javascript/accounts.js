let members = [];
    const modal = document.getElementById('editMemberModal');
    const closeBtn = document.getElementsByClassName('close')[0];
    const cancelBtn = document.querySelector('.cancel-btn');

    function fetchMembers() {
        fetch('../PHP/accounts.php') 
            .then(response => response.json())
            .then(data => {
                const storedMembers = JSON.parse(localStorage.getItem('memberData') || '{}');
                
                members = data.map(member => {
                    const storedMember = storedMembers[member.id] || {};
                    return {
                        ...member,
                        birthday: storedMember.birthday || generateRandomBirthday(),
                        phone: storedMember.phone || `+60 12-345 ${Math.floor(1000 + Math.random() * 9000)}`,
                        status: storedMember.status || 'Active'
                    };
                });
                
                const memberData = members.reduce((acc, member) => {
                    acc[member.id] = {
                        birthday: member.birthday,
                        phone: member.phone,
                        status: member.status
                    };
                    return acc;
                }, {});
                localStorage.setItem('memberData', JSON.stringify(memberData));
                
                displayMembers(members);
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error fetching members data');
            });
    }

    function displayMembers(membersToShow = members) {
        const memberList = document.getElementById('memberList');
        memberList.innerHTML = '';

        membersToShow.forEach(member => {
            const memberCard = document.createElement('div');
            memberCard.className = 'member-card';
            memberCard.innerHTML = `
                <div class="member-header">
                    <div class="member-info">
                        <h3>${member.name}</h3>
                        <p>${member.email}</p>
                    </div>
                </div>
                <div class="member-details">
                    <p><i class="fas fa-key"></i> Password: ${member.password}</p>
                    <p><i class="fas fa-phone"></i> ${member.phone}</p>
                    <p><i class="fas fa-birthday-cake"></i> ${member.birthday}</p>
                    <p><i class="fas fa-calendar-alt"></i> Join Date: ${formatDate(member.created_at)}</p>
                    <p><i class="fas fa-clock"></i> Last Updated: ${formatDate(member.updated_at)}</p>
                    <p><i class="fas fa-circle" style="color: ${member.status === 'Active' ? '#4CAF50' : '#FF5722'}"></i> Status: ${member.status}</p>
                </div>
            `;
            memberCard.addEventListener('click', () => openEditModal(member));
            memberList.appendChild(memberCard);
        });
    }

    function openEditModal(member) {
        document.getElementById('editMemberId').value = member.id;
        document.getElementById('editName').value = member.name;
        document.getElementById('editEmail').value = member.email;
        document.getElementById('editPhone').value = member.phone;
        document.getElementById('editBirthday').value = member.birthday;
        document.getElementById('editStatus').value = member.status;
        document.getElementById('editPassword').value = '';
        
        modal.style.display = 'block';
    }

    document.getElementById('editMemberForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const memberId = document.getElementById('editMemberId').value;
        const memberIndex = members.findIndex(m => m.id === memberId);
        
        if (document.getElementById('editPassword').value) {
            updateMember({
                id: memberId,
                password: document.getElementById('editPassword').value
            });
        }

        if (memberIndex !== -1) {
            const updatedMember = {
                ...members[memberIndex],
                phone: document.getElementById('editPhone').value,
                birthday: document.getElementById('editBirthday').value,
                status: document.getElementById('editStatus').value,
                updated_at: new Date().toISOString()
            };
            
            members[memberIndex] = updatedMember;
            
            const storedMembers = JSON.parse(localStorage.getItem('memberData') || '{}');
            storedMembers[memberId] = {
                birthday: updatedMember.birthday,
                phone: updatedMember.phone,
                status: updatedMember.status
            };
            localStorage.setItem('memberData', JSON.stringify(storedMembers));
            
            displayMembers();
            modal.style.display = 'none';
        }
    });

    async function updateMember(data) {
        try {
            const response = await fetch('../PHP/accounts.php', { 
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            });

            const result = await response.json();
            
            if (result.success) {
                fetchMembers();
                alert('Member updated successfully!');
            } else {
                alert('Error updating member: ' + result.message);
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Error updating member');
        }
    }

    function generateRandomBirthday() {
        const start = new Date(1970, 0, 1);
        const end = new Date(2000, 11, 31);
        const randomDate = new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
        return randomDate.toISOString().split('T')[0];
    }

    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    }

    function searchMember() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const filteredMembers = members.filter(member => 
            member.name.toLowerCase().includes(searchTerm)
        );
        displayMembers(filteredMembers);
    }

    // Event Listeners
    document.addEventListener('DOMContentLoaded', fetchMembers);
    document.getElementById('searchInput').addEventListener('keypress', (e) => {
        if (e.key === 'Enter') searchMember();
    });
    closeBtn.onclick = () => modal.style.display = 'none';
    cancelBtn.onclick = () => modal.style.display = 'none';
    window.onclick = (e) => {
        if (e.target === modal) modal.style.display = 'none';
    };

function displayMembers(membersToShow = members) {
    const memberList = document.getElementById('memberList');
    memberList.innerHTML = '';

    membersToShow.forEach(member => {
        const memberCard = document.createElement('div');
        memberCard.className = 'member-card';
        memberCard.innerHTML = `
            <div class="member-header">
                <div class="member-info">
                    <h3>${member.name}</h3>
                    <p>${member.email}</p>
                </div>
            </div>
            <div class="member-details">
                <p><i class="fas fa-key"></i> Password: ${member.password}</p>
                <p><i class="fas fa-phone"></i> ${member.phone}</p>
                <p><i class="fas fa-birthday-cake"></i> ${member.birthday}</p>
                <p><i class="fas fa-calendar-alt"></i> Join Date: ${formatDate(member.created_at)}</p>
                <p><i class="fas fa-clock"></i> Last Updated: ${formatDate(member.updated_at)}</p>
                <p><i class="fas fa-circle" style="color: ${member.status === 'Active' ? '#4CAF50' : '#FF5722'}"></i> Status: ${member.status}</p>
            </div>
        `;
        memberCard.addEventListener('click', () => openEditModal(member));
        memberList.appendChild(memberCard);
    });
}

function openEditModal(member) {
    document.getElementById('editMemberId').value = member.id;
    document.getElementById('editName').value = member.name;
    document.getElementById('editEmail').value = member.email;
    document.getElementById('editPhone').value = member.phone;
    document.getElementById('editBirthday').value = member.birthday;
    document.getElementById('editStatus').value = member.status;
    document.getElementById('editPassword').value = '';
    
    modal.style.display = 'block';
}

document.getElementById('editMemberForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const memberId = document.getElementById('editMemberId').value;
    const memberIndex = members.findIndex(m => m.id === memberId);
    
    // Update password on backend
    const passwordUpdate = {
        id: memberId,
        password: document.getElementById('editPassword').value
    };

    if (passwordUpdate.password) {
        updateMember(passwordUpdate);
    }

    // Update frontend-only fields in memory
    if (memberIndex !== -1) {
        members[memberIndex] = {
            ...members[memberIndex],
            phone: document.getElementById('editPhone').value,
            birthday: document.getElementById('editBirthday').value,
            status: document.getElementById('editStatus').value,
            updated_at: new Date().toISOString()
        };
        
        displayMembers();
        modal.style.display = 'none';
    }
});

// Keep existing helper functions
function generateRandomBirthday() {
    const start = new Date(1970, 0, 1);
    const end = new Date(2000, 11, 31);
    const randomDate = new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
    return randomDate.toISOString().split('T')[0];
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}


// Initialize
document.addEventListener('DOMContentLoaded', fetchMembers);
document.getElementById('searchInput').addEventListener('keypress', (e) => {
    if (e.key === 'Enter') searchMember();
});

// Modal close handlers
closeBtn.onclick = () => modal.style.display = 'none';
cancelBtn.onclick = () => modal.style.display = 'none';
window.onclick = (e) => {
    if (e.target === modal) modal.style.display = 'none';
};