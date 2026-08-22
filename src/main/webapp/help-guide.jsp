<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Guide | Sunrise Dental Clinic</title>

    <!-- tailwind cdn (same version as login.jsp, for a consistent public-page look) -->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>

    <link rel="icon" href="${pageContext.request.contextPath}/assets/favicon.ico" type="image/x-icon">
</head>

<%-- Standalone page: no sidebar, no login required. Linked from the login
     screen so anyone can read it before signing in. --%>
<body class="bg-gray-50 text-slate-700">

  <%-- Simple top bar: logo + title + a way back to the login page --%>
  <header class="bg-white border-b border-gray-200">
    <div class="max-w-3xl mx-auto px-6 py-4 flex items-center justify-between">
      <div class="flex items-center gap-3">
        <img src="${pageContext.request.contextPath}/assets/logo-bg.png" class="h-9 w-9 rounded-lg object-cover" alt="logo">
        <div>
          <p class="font-bold text-slate-800 leading-tight">Sunrise Dental</p>
          <p class="text-xs text-slate-400">Help Guide</p>
        </div>
      </div>
      <a href="${pageContext.request.contextPath}/login"
         class="text-sm font-medium text-blue-600 hover:underline">Back to Login</a>
    </div>
  </header>

  <main class="max-w-3xl mx-auto px-6 py-8">
    <h1 class="text-2xl font-bold text-slate-800 mb-1">Help &amp; Instructions</h1>
    <%@ include file="/WEB-INF/views/partials/help-content.jsp" %>
  </main>

</body>
</html>
