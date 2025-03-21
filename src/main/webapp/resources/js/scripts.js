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

// document.addEventListener("DOMContentLoaded", function () {
//     const enableDueDate = document.getElementById("enableDueDate");
//     const datepickerContainer = document.getElementById("datepicker-container");
//     const dueDateInput = document.getElementById("dueDate");
//     enableDueDate.addEventListener("change", function () {
//         if (this.checked) {
//             datepickerContainer.style.display = "block";
//             if (!$.data($("#datepicker-inline")[0], "datepicker")) {
//                 $("#datepicker-inline").datepicker({
//                     dateFormat: "yy-mm-dd",
//                     onSelect: function (dateText) {
//                         dueDateInput.value = dateText;
//                     }
//                 });
//             }
//         } else {
//             datepickerContainer.style.display = "none";
//             dueDateInput.value = "";
//         }
//     });
// });

document.addEventListener("DOMContentLoaded", function () {
    const enableDueDate = document.getElementById("enableDueDate");
    const datepickerContainer = document.getElementById("datepicker-container");
    const dueDateInput = document.getElementById("dueDate");

    enableDueDate.addEventListener("change", function () {
        if (this.checked) {
            datepickerContainer.style.display = "block";

            // Lấy ngày hôm nay
            const today = new Date();
            today.setHours(0, 0, 0, 0); // Đặt thời gian về 00:00:00 để tránh lỗi múi giờ

            // Nếu Datepicker chưa khởi tạo, khởi tạo với minDate
            if (!$.data($("#datepicker-inline")[0], "datepicker")) {
                $("#datepicker-inline").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: today, // 🔒 Khóa các ngày trước hôm nay
                    onSelect: function (dateText) {
                        dueDateInput.value = dateText;
                    }
                });
            } else {
                // Nếu Datepicker đã tồn tại, cập nhật minDate mỗi khi bật
                $("#datepicker-inline").datepicker("option", "minDate", today);
            }

            // Đặt ngày mặc định là hôm nay
            $("#datepicker-inline").datepicker("setDate", today);
            dueDateInput.value = today.toISOString().split("T")[0];
        } else {
            datepickerContainer.style.display = "none";
            dueDateInput.value = "";
        }
    });
});
