window.addEventListener('DOMContentLoaded', event => {
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }
});

function formatDateTime(dateInput) {
    const date = new Date(dateInput);
    const day = date.getDate().toString().padStart(2, '0');
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear();
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');

    return `${day}/${month}/${year} ${hours}:${minutes}`;
}

window.formatDateTime = formatDateTime;

document.addEventListener('DOMContentLoaded', () => {
    const pElement = document.querySelector('.text-white-50.small');
    const createdAtRaw = pElement.getAttribute('data-created-at');
    const formattedDate = formatDateTime(createdAtRaw);
    pElement.innerHTML = `<i class="fas fa-calendar-alt me-1"></i> ${formattedDate}`;
});
