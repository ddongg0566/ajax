<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<body>
	시도 선택: <select id="sidoList">
	</select>
	<button id="sidoBtn">찾기</button>
	<table border="1">
		<thead>
			<tr>
				<th>ID</th>
				<th>센터명</th>
				<th>주소</th>
				<th>연락처</th>
				<th>시도</th>
			</tr>
		</thead>
		<tbody id="centerList"></tbody>
	</table>


	<script>
		let showFields = ['id', 'centerName', 'address', 'phoneNumber', 'sido']


		//row 생성.

		function makeTr(center = {}) {
			//tr 생성 >td 여러개
			let tr = document.createElement('tr');
			tr.setAttribute('data-lng', center.lng);
			tr.setAttribute('data-lat', center.lat);
			tr.setAttribute('data-name', center.centerName);
			
			tr.addEventListener('click',openMapFnc);
			//td 생성
			showFields.forEach(function (field) {
				let td = document.createElement('td');
				td.innerText = center[field];
				tr.append(td);
			})
			return tr;
		}
		
		function  openMapFnc(){
			let tr = this;
			let lng= tr.dataset.lng; //tr.getAttribute('data-lng');
			let lat = tr.dataset.lat;
			let name= tr.dataset.name;
			location.href = 'map.do?lng=' + lng + '&lat=' + lat+"&name=" + name;
		}

		// 전체목록
		let totalList; // 다른 함수에도 활용
		let url =
			'https://api.odcloud.kr/api/15077586/v1/centers?page=1&perPage=284&serviceKey=8o71T%2FqGgXATSj0S%2Frzx9YtBBH9fN6r68l7tzyQdyVLfJD1kTJOj%2BWkxeUj1qpesRWdRuwwzAhU1kuwwoFCAeA%3D%3D';
		fetch(url)
			.then(resolve => resolve.json())
			.then(result => {
				console.log(result);
				let aryData = result.data;
				totalList = aryData; // 처리결과를 활용해서 totalList 대입.
				aryData.forEach(function (center) {
					let tr = makeTr(center);
					document.querySelector('#centerList').append(tr);
				});


				//시도배열
				// totalList; //{id, centerName, address, sido}
				// push, pop, unshift, shift
				let sidoAry = [];

				totalList.forEach(center => {
					if (sidoAry.indexOf(center.sido) == -1) {
						sidoAry.push(center.sido)
					}
				})

				sidoAry.forEach(function (sido) {
					let opt = document.createElement('option');
					opt.value = sido;
					opt.innerText = sido;
					document.querySelector('#sidoList').append(opt);
				});

			})



		//찾기 버튼
		document.querySelector('#sidoBtn').addEventListener('click', findSidoFnc);

		function findSidoFnc() {
			document.querySelector('#centerList').innerHTML = "";


			let searchWord = document.getElementById('sidoList').value;
			//전체목록.검색조건 filter한 결과를 tbody의 하위목록으로 출력.
			let filterAry = totalList.filter(function (center) {
				console.log(center);
				return center.sido == searchWord;
			});


			filterAry.forEach(center => {

				document.querySelector('#centerList').append(makeTr(center));
			});
		}
	</script>
</body>

</html>