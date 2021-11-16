<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="<c:url value="/resources/js/main.js"/>"></script>
<link rel="stylesheet" href="/resources/css/styles.css" />
<link rel="icon" type="image/png" href="http://example.com/myicon.png">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.detail{
  height: 300vh;
  width: 90%;
  margin: 0 auto;
}
.hidden {
  display: none;
}
.searchresult {
  display: flex;
  align-items: flex-end;
  margin-top: 20px;
}
.searchresult h1 {
  font-size: 30px;
}
.searchresult h2 {
  font-size: 19px;
}
.searchfriendsdiv input[type="text"] {
  margin: 20px 0;
  padding: 15px;
  font-size: large;
  border-radius: 50px;
  border: none;
  width: 400px;
}
.searchfriendsdiv input:not([type="text"]) {
  display: none;
}
.userList {
  position: relative;
  z-index: 9;
  border-radius: 1px solid black;
  width: 600px;
}
.background {
  position: absolute;
  width: 100%;
  height: 77%;
  opacity: 70%;
  z-index: 11;
  background-color: black;
}
.userList{
  margin: 20px 0;
}
.userList:nth-child(odd) {
  float: left;
}
.userList:nth-child(even) {
  float: right;
}
.userList__pro {
  position: absolute;
  z-index: 10;
  top: 25px;
  left: 240px;
}
.userList__pro img {
  border-radius: 50%;
}
.userList__proBack {
  filter: brightness(40%) opacity(50%) blur(1px);
  border: 1px solid black;
}
.userList__proBack img {
  z-index: -1;
}
.userList__cid {
  padding: 30px 10px;
  background-color: white;
}
.profileBtn {
  position: absolute;
  border: none;
  font-size: 17px;
  padding: 13px 70px;
  border-radius: 5px;
  background-color: var(--mainColor);
  color: white;
  top: 100px;
  left: 230px;
  z-index: 12;
}
.profileBtn:hover{
  background-color: rgba(245, 109, 46, 0.8);
  cursor: pointer;
}
.notyet {
  display: none;
}
/*
.pageList{
  margin-top: 1000px;
}
*/
.page-item.active .page-link {
  background-color: var(--mainColor);
  border-color: var(--mainColor);
}
.page-link {
  color: black;
}
</style>
<body>
<!-- 
		criteria 정보 확인: ${page }<br>
		page 확인: ${page.cri.pageNum }<br>
		시작페이지: ${page.startPage }<br>
		끝페이지: ${page.endPage }<br>
		keyword 확인: ${page.cri.keyword }<br>
		parameter로 넘어온 cid 확인: ${param.cid }<br>
 -->
    <div class="display">
      <!-- side-bar -->
      <div class="side-bar">
        <!-- logo -->
        <div class="side-bar__row">
          <!-- 클릭하면 main화면으로 돌아오도록 a 태그 수정 -->
          <span
            ><a href="/main/main"><img src="/resources/css/image/logo.png" /></a
          ></span>
        </div>
        <!-- search -->
        <div class="side-bar__row">
          <form action="/gameInfo/gamelist" method="get">
          <select name="searchType" style="display:none">
          	<option  value="n"
				<c:out value="${btnMaker.cri.searchType eq 'n' ? 'selected' : '' }"/>>
				</option>
            </select>
            <input type="text" placeholder="Search Game" name="keyword" value="${btnMaker.cri.keyword }"/>
            <!-- origin처럼 버튼 숨겼음, enter 치면 검색됨 -->
            <input type="submit" value="" />
          </form>
        </div>
        <!-- category -->
        <div class="side-bar__row">
          <span><a href="/gameInfo/gamelist">게임 스토어</a></span>
          <c:if test="${cid ne null}">
          	<span><a href="/library/conLibrary?cid=${cid}">라이브러리</a></span>
          </c:if>
        </div>
        <!-- qna -->
        <div class="side-bar__row">
          <span><a href="/qna/questionlist">Q&A</a></span>
          &nbsp;&nbsp;|&nbsp;&nbsp;
          <span><a href="/qna/commonquestion">자주하는 질문</a></span>
        </div>
        <!-- about user -->
        <div class="side-bar__row">
          <!-- c:if로 로그인 전에는 회원가입+로그인 / 로그인 후에는 프로필 -->
          <c:if test="${cid eq null }">
	          <div class="loginBtn">
	        	<span><a href="/user/userLogin" class="loginA">로그인</a></span>
	          </div>
	          <div class="joinBtn">
	        	<span><a href="/user/agreeJoin" class="joinA">가입하기</a></span>
	          </div>
       	  </c:if>
          <c:if test="${cid ne null}">
	          <div class="consumer">
	          	  <div class="consumer__imgPro">
			        <img class="conimg" src="/resources/css/image/chaIcon.png"/>
	          	  </div>
		          <div class="consumer__nickname">
		          	<p style="color:white;"><sec:authentication property="principal.consumer.nickname"/></p>
		          </div>
		          <div class="consumer__info">
	   				<a href="/user/userGet">* 내정보</a><br/>
	   				<a href="/user/userPro">* 프로필</a>
	   				<a href="/friends/followerlist">* 팔로워리스트</a><br/>
	   				<a href="/friends/followinglist">* 팔로잉리스트</a><br/>
	   				<a href="/friends/searchfriends">* 친구 검색</a><br/>
		   		  </div>
				  <form action="/user/userLogout" method="post">
					  <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
					  <input class="logout" type="submit" value="로그아웃" />
				  </form>
	          </div>
          </c:if>
        </div>
      </div>
      <div class="main">
        <div class="contents">
          <div class="detail">
          <!-- start -->
	<div class="searchresult">
	<h1>검색</h1>	
	<h2 class="searchtotal hidden">(${page.total })</h2>
	</div>
	<div class="searchfriendsdiv">
	<form action="/friends/searchfriends?cid=${param.cid }&keyword=${page.cri.keyword }">
		<input class="searchfriendsinput" type="text" name="keyword" value="${page.cri.keyword }" placeholder="닉네임 또는 아이디로 친구 검색"/>
		<input type="hidden" name="cid" value="${param.cid }" />
		<input type="submit" value="검색"/>
	</form>
	</div>
	<!-- 처음에는 비어있다가 검색하면 나타나도록 작성 -->
	<div class="infinite hidden">
		<c:forEach items="${userList }" var="userList">
			<div class="userList">
				<div class="background notyet"></div>
				<div class="userList__pro"><img src="/resources/css/image/friends.png" width="200"/></div>
				<div class="userList__proBack"><img src="/resources/css/image/friends.png" width="600" height="250"/></div>
				<div class="userList__cid">${userList.cid }(${userList.nickname })</div>
				<!-- 해당 유저 프로필로 이동하고 거기서 친구 추가 혹은 삭제 로직 진행, url 바꾸면서 아래 hidden 삭제 예정 -->
				<form action="/user/userPro?cid=" method="get">
					<input type="hidden" name="cid" value="${userList.cid }" />
				<!-- 
					<input type="hidden" name="following" value="${param.cid }" />
					<input type="hidden" name="follower" value="${userList.cid }" />
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
				 -->
					<input class="profileBtn notyet" type="submit" value="프로필 보기" />
				</form>
			</div>
		</c:forEach>
	</div>
	<nav class="pageList hidden" aria-label="...">
	<div class="pagination justify-content-center">
	 <c:if test="${page.prev }">
	 	<li class="page-item">
	 		<a class="page-link" href="/friends/searchfriends?cid=${param.cid }&pageNum=${page.startPage - 1 }&keyword=${page.cri.keyword }">이전</a>
	 	</li>
	 </c:if>
	 <c:forEach var="pageNum" begin="${page.startPage }" end="${page.endPage }">
	 	<li class="page-item ${page.cri.pageNum == pageNum ? 'active' : '' }">
			<a class="page-link" href="/friends/searchfriends?cid=${param.cid }&pageNum=${pageNum }&keyword=${page.cri.keyword }">${pageNum }</a>
		</li>	
	 </c:forEach>
	 	 <c:if test="${page.next }">
	 	<li class="page-item">
	 		<a class="page-link" href="/friends/searchfriends?cid=${param.cid }&pageNum=${page.endPage + 1 }&keyword=${page.cri.keyword }">다음</a>
	 	</li>
	 </c:if>
	</div>
	</nav>

    <script type="text/javascript">
 	
 	// 처음에는 안보이다가 검색하면 나타나도록 작성
	const input = document.querySelector(".searchfriendsinput");
	const searchtotal = document.querySelector(".searchtotal");
	let keyword = input.getAttribute("value");
	//const detail = document.querySelector(".detail");
	console.log(keyword);
	if(keyword != ""){
		const infinite = document.querySelector(".infinite");
		const pageList = document.querySelector(".pageList");
		console.log("pageList 확인: " + pageList);
		infinite.classList.remove("hidden");
		pageList.classList.remove("hidden");
		searchtotal.classList.remove("hidden");
	}
	
	// 
    let num;
    const total = ${page.total };
	const userLists = document.querySelectorAll(".userList");
	
    const showBtns = document.querySelectorAll(".profileBtn");
    const backGrounds = document.querySelectorAll(".background");
    userLists.forEach(function(userList){
    	userList.addEventListener("mouseover", function(event){
    		this.getElementsByTagName('input')[1].classList.remove("notyet");
    		this.children[0].classList.remove("notyet");
    	});
    	userList.addEventListener("mouseout", function(event){
    		this.getElementsByTagName('input')[1].classList.add("notyet");
    		this.children[0].classList.add("notyet");
    	});
    });
  </script>
            </div>
        </div>
        <div class="footer">
          <div class="footer-info">
            <div>CREATORS&nbsp;&nbsp;김영훈, 김지우, 조훈현, 최재인</div>
            <div>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</div>
            <div>
              CONTACT&nbsp;&nbsp;<a href="https://github.com/GITJIWOO/Game-Project"
                >https://github.com/GITJIWOO/Game-Project</a
              >
            </div>
          </div>
          <div class="footer-copyright">
            <div>Copyright © GAMMA All right reserved.</div>
          </div>
        </div>
      </div>
    </div>
</body>
</html>