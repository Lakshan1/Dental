<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Help | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="help" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Help"/>
        <jsp:param name="pageSubtitle" value="How to use the system"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">
        <div class="max-w-3xl">
          <h2 class="text-2xl font-bold text-slate-800 mb-1">Help &amp; Instructions</h2>
          <%@ include file="/WEB-INF/views/partials/help-content.jsp" %>
        </div>
      </main>
    </div>
  </div>
</body>
</html>
