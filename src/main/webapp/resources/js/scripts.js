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
        format: 'yyyy-mm-dd',
        language: 'vi',
        todayHighlight: true,
        inline: true
    }).on('changeDate', function (e) {
        $('#dueDate').val(e.format('yyyy-mm-dd'));
    });
    var initialDate = $('#dueDate').val();
    if (initialDate) {
        $('#datepicker-inline').datepicker('setDate', initialDate);
    }
});

document.addEventListener("DOMContentLoaded", function () {
    const enableDueDate = document.getElementById("enableDueDate");
    const datepickerContainer = document.getElementById("datepicker-container");
    const dueDateInput = document.getElementById("dueDate");
    enableDueDate.addEventListener("change", function () {
        if (this.checked) {
            datepickerContainer.style.display = "block";
            if (!$.data($("#datepicker-inline")[0], "datepicker")) {
                $("#datepicker-inline").datepicker({
                    dateFormat: "yy-mm-dd",
                    onSelect: function (dateText) {
                        dueDateInput.value = dateText;
                    }
                });
            }
        } else {
            datepickerContainer.style.display = "none";
            dueDateInput.value = "";
        }
    });
});