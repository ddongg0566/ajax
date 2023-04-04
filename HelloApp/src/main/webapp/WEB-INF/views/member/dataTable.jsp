<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="//cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="jquery/jquery-3.6.4.min.js"></script>
    <script src="//cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
                    //리스트
                    $('#example').DataTable({
                        ajax: 'dataTableAjax.do',
                    });

                    // add
                    var t = $('#example').DataTable();


                    $('#addRow').on('click', function () {

                        $.ajax({

                            url: "dataAddAjax.do",
                            method: "GET", // HTTP 요청 방식(GET, POST)
                            data: {
                                first: $('#first').val(),
                                last: $('#last').val(),
                                email: $('#email')
                                    .val(),
                                hire: $('#hireDate').val(),
                                salary: $('#salary').val()
                            },

                            success: function (result) {
                                if (result.retCode == 'Success') {

                                    alert("성공");
                                    t.row.add([$('#first').val(), $('#last').val(), $('#email')
                                        .val(), $('#hireDate').val(), $('#salary').val()
                                    ]).draw(
                                        false);
                                } else if (result.retCode == 'Fail') {

                                };
                            }
                        })
                    
                    });
                });
    </script>
</head>

<body>
    <p>dataTable</p>
    <input type="text" id="first" required="required"><br>
    <input type="text" id="last" required="required"><br>
    <input type="email" id="email" required="required"><br>
    <input type="date" id="hireDate" required="required"><br>
    <input type="number" id="salary" required="required"><br>
    <button id="addRow">등록</button><br>



    <table id="example" class="display" style="width:100%">
        <thead>
            <tr>
                <th>사원번호</th>
                <th>FirstName</th>
                <th>lastName</th>
                <th>Email</th>
                <th>HireDate</th>
                <th>Salary</th>
            </tr>



        </thead>
        <tfoot>
            <tr>
                <th>사원번호</th>
                <th>FirstName</th>
                <th>lastName</th>
                <th>Email</th>
                <th>HireDate</th>
                <th>Salary</th>
            </tr>
        </tfoot>
    </table>





</body>

</html>