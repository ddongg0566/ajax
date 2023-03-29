<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3>Tiles가 적용된 member 페이지</h3>
<div>
  <form>
    <table class="table">
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
        <td>Mail:</td>
        <td><input type="text" id="email"></td>
      </tr>
      <tr>
        <td>Auth:</td>
        <td><input type="text" id="auth"></td>
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
  <table class="table">
    <thead>
      <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Pass</th>
        <th>Mail</th>
        <th>Auth</th>
        <th>삭제</th>
      </tr>
    </thead>
    <tbody id="list">
    </tbody>
  </table>
</div>



<script>
  // 목록 출력 기능.
  fetch('memberListAjax.do') // json 포맷으로 데이터 정상.
    .then(function (resolve) {
      //console.log(resolve); // body: readablestream
      return resolve.json(); // json포맷에 따라 javascript object변경.
    })
    .then(function (result) {
      console.log(result); // result: [{id,name,pass,mail,auth},{},{},{}....{}]
      for (let i = 0; i < result.length; i++) {
        let id = result[i].id;
        makeTr(result[i]);
      }
    })
    .catch(function (reject) {
      console.error(reject);
    })

  // 등록버튼 클릭이벤트.
  document.getElementById('addBtn').addEventListener('click', function (e) {
    e.preventDefault(); // 기본기능차단.

    let id = document.getElementById('id').value;
    let nm = document.getElementById('name').value;
    let pw = document.getElementById('passwd').value;
    let ma = document.getElementById('email').value;
    let au = document.getElementById('auth').value;

    if (!id || !nm || !pw || !ma || !au) {
      alert("값을 입력!!");
      return;
    }
    // ajax호출.
    fetch('memberAddAjax.do', {
        method: 'post',
        headers: {
          'Content-type': 'application/x-www-form-urlencoded'
        },
        body: 'id=' + id + '&name=' + nm + '&pw=' + pw + '&mail=' + ma + '&auth=' + au
      })
      .then(resolve => resolve.json()) // {"id":"user1", "name":"hong"...}
      .then(result => {
        console.log(result); // {member: {…}, retCode: 'Success'}
        if (result.retCode == 'Success') {
          alert('성공!!');
          // 추가된 값을 화면 출력. start.
		  makeTr(result.member);
          // 추가된 값 화면 출력. end.
		  initField();

        } else if (result.retCode == 'Fail') {
          alert('예외발생!!');
        }
      })
      .catch(reject => console.error(reject));
  })

  // tr 생성.
  function makeTr(member = {}) {
    // 완료. tr>td+td+td+td+td+td>button
    let tr = document.createElement('tr');
    // td 만들기.(아이디,이름,비번,메일,권한)
    for (let prop in member) { // for .. in .. object 의 필드반복.
      let td = document.createElement('td');
      td.innerText = member[prop];
      tr.append(td);
    }
    // 삭제버튼.
    let delBtn = document.createElement('button'); // <button>삭제</button>
    delBtn.innerText = '삭제';
    delBtn.addEventListener('click', function () {
      console.log(this); // this => 이벤트 대상.
      console.log(this.parentElement.parentElement.children[0].innerText)
      let delId = this.parentElement.parentElement.children[0].innerText;
      // ajax 호출.
      fetch('memberRemoveAjax.do', {
          method: 'post',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }, // key=val&key&val
          body: 'id=' + delId
        })
        .then(resolve => resolve.json()) // resolve => {"retCode":"Success"}
        .then(result => {
          console.log(result); // 
          if (result.retCode == 'Success') {
            alert('성공!');
            this.parentElement.parentElement.remove();
          } else if (result.retCode == 'Fail') {
            alert('실패!');
          }
        })
        .catch(reject => console.log(reject));

    });

    let td = document.createElement('td');
    td.append(delBtn); // <td><button>삭제</button></td>
    tr.append(td); // <tr> <td/><td/><td/><td/>..  <td><button>삭제</button></td></tr>

    document.getElementById('list').append(tr);

  }
  
  function initField() {
	  document.getElementById('id').value = '';
	  document.getElementById('name').value = '';
  }
</script>