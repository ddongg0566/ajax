<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="jquery/jquery-3.6.4.min.js"></script>
    <script>
        //document 로딩 후 처리.
        $(document).ready(function () {

            // fetch('url', {option})
            $.ajax({
                url: "memberListJquery.do", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
                data: {
                    name: "홍길동", //request.getParameter('name');
                    id: 'user01'
                }, // HTTP 요청과 함께 서버로 보낼 데이터
                method: "GET", // HTTP 요청 방식(GET, POST)
                dataType: "json", // 서버에서 보내줄 데이터의 타입: JSON.parse()실행
                success: function (result) { //서버요헝의 성공시 실행
                    console.log(result);
                    $(result).each(function (idx, member) {
                        console.log(idx, member);
                        $('#list').append(
                            //tr>td*4
                            $('<tr />').append($('<td />').text(member.memberId),
                                $('<td />').text(member.memberName),
                                $('<td />').text(member.memberAddr),
                                $('<td />').text(member.memberTel),
                                $('<td />').text(member.memberPw),
                                $('<td />').append($('<button />').text('삭제').on(
                                    'click', rowDeleteFnc)),
                                $('<td />').append('<input type="checkbox" />')
                            )
                        );
                    });
                },
                error: function (err) { //서버요청의 실패시 실행
                    console.error(err);
                }
            }) //$.ajax가 끝나는 부분


            $('#list').on('change', 'td>input[type="checkbox"]', function () {
                    //$('td>input[type="checkbox"').on('change',function (){
                    console.log(this);
                    let checkCnt = $('td>input[type="checkbox"]:checked').length;
                    let allCnt = $('td>input[type="checkbox"]').length;
                    if (checkCnt == allCnt) {
                        $('th>input[type="checkbox"]').prop({
                            checked: true
                        })

                    } else {
                        $('th>input[type="checkbox"]').prop({
                            checked: false
                        })
                    }
                
        
            })
        



        //삭제버튼 이벤트& 이벤트 핸들러
        function rowDeleteFnc() {
            $(this).parentsUntil('tbody').remove(); //this=button

        }
        //선택삭제 기능
       $('#delSelected').on('click', function (e) {
                e.preventDefault();
                let memberIdAray = '';
                console.log($('#list input:checked'));
                $('#list input:checked').each(function (idx, item) {
                	
                	console.log($(item).parent().parent().attr('id'));
                    //memberIdAray.push({'memberId':$(item).parent().parent().memberId})
                	memberIdAray += '&memberId='+ $(item).parent().parent().attr('id');
                    //$(item).parentsUntil('tbody').remove();
                })
					console.log(memberIdAray);
                
                	// ajax호출
                	$.ajax({
                		url:'memberRemoveJquery.do', //호출할 컨트롤
                		method:'post',
                		data: memberIdAray.substring(1),
                		success: function(result){
                			if(result.retCode = 'Success')
                				
                			$('#list input:checked').closest('tr').remove();
                			else
                				alert('error!!');
                		},
                		error: function(reject){
                			console.log(reject)
                		}
                	})
                	
            })
	//전체 선택
        $('th>input[type="checkbox"]').on('change', function () {
            $('td>input').prop({
                checked: this.checked
            })
        })

        //등록버튼 이벤트& 이벤트
        $('#addBtn').on('click', function (event) {
            event.preventDefault();
            
            //사용자가 필수입력갑을 입력했는디 validation 하고
             if( !$('#id').val()|| !$('#name').val()||!$('#addr').val()||!$('#tel').val()||!$('#passwd').val()){
            	 alert("빈칸을 모두체우세요")
             
            	return;
            }
             
            
            $.ajax({

                url: "memberAddJquery.do", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소

                data: { id:$('#id').val(), name:$('#name').val() , addr:$('#addr').val() , tel:$('#tel').val() , passwd:$('#passwd').val()  
                	},                          // HTTP 요청과 함께 서버로 보낼 데이터
                

                method: "GET",                                     // HTTP 요청 방식(GET, POST)

                dataType: "json",                                   // 서버에서 보내줄 데이터의 타입
				
                
                success:function(result){
                	if (result.retCode == 'Success'){
                        $('#list').append(
                            //tr>td*4
                            $('<tr />').append($('<td />').text($('#id').val()),
                                $('<td />').text($('#name').val()),
                                $('<td />').text($('#passwd').val()),
                                $('<td />').text($('#addr').val()),
                                $('<td />').text($('#tel').val()),
                                $('<td />').append($('<button />').text('삭제').on(
                                    'click', rowDeleteFnc)),
                                $('<td />').append('<input type="checkbox" />')
                            )
                        );
                		//성공
                	}else if (result.retCode =='Fail'){
                        //처리중 에러
                	}else{
                        //반환코드확인
                	}
                },
                error:function(reject){
                    
                }
            })
            
        });
            
        });
    </script>
</head>

<body>
    <div>
        <form>
            <table class="table" border="1">
                <tr>
                    <td>Id:</td>
                    <td><input type="text" id="id"></td>
                </tr>
                <tr>
                    <td>Name:</td>
                    <td><input type="text" id="name"></td>
                </tr>
                <tr>
                    <td>Pass:</td>
                    <td><input type="text" id="passwd"></td>
                </tr>
                <tr>
                    <td>Addr:</td>
                    <td><input type="text" id="addr"></td>
                </tr>
                <tr>
                    <td>Tel</td>:</td>
                    <td><input type="text" id="tel"></td>
                </tr>

                <tr>
                    <td colspan='2' align="center">
                        <button id="addBtn">등록</button>
                        <button id="delSelected">선택삭제</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div>
        <table class="table" border="1">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Pass</th>
                    <th>Addr</th>
                    <th>Tel</th>
                    <th>Delete</th>
                    <th><input type="checkbox"></th>

                </tr>
            </thead>
            <tbody id="list">

            </tbody>
        </table>
    </div>
</body>

</html>