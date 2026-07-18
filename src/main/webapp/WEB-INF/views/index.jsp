<!DOCTYPE html>
<html>
<head>
  <title>Dental</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
  <c:if test="${not empty sessionScope.user}">
    Welcome, ${sessionScope.user.name}
  </c:if>
</body>
</html>
