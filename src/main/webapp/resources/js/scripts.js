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

$(document).ready(function () {
    $('#datepicker-inline').datepicker({
        format: 'dd/mm/yyyy',
        language: 'vi',
        todayHighlight: true,
        inline: true
    }).on('changeDate', function (e) {
        $('#dueDate').val(e.format('dd/mm/yyyy'));
    });
    var initialDate = $('#dueDate').val();
    if (initialDate) {
        $('#datepicker-inline').datepicker('setDate', initialDate);
    }
});
