<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div id="body">
		<div id="content">
			<div id="review">
				<div id="reviewContent">
					${review}
				</div>
				<div id="reviewComment">
					<!-- 리뷰 댓글 삭제는 hidden으로 grnum 과 rcnum을 보내야 한다. -->
					<c:forEach var="reviewComment" items="${reviewComment}">
						${reviewComment.cid}
						${reviewComment.rcdate}
						${reviewComment.rccontent}
						<hr/>
					</c:forEach>
					<nav aria-label="Page navigation example">
					  <ul class="pagination">
					  	<c:if test="${pageBtn.prev}">
						    <li class="page-item">
						      <a class="page-link" href="#">	 
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
					    </c:if>
					    <c:forEach var="pageBtn" items="${pageBtns}">
					    	<li class="page-item"><a class="page-link" href="#">${pageBtn.rcnum}</a></li>
					    </c:forEach>
					    <c:if test="${pageBtn.next}">
						    <li class="page-item">
						      <a class="page-link" href="#">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
					    </c:if>
					  </ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</body>
</html>