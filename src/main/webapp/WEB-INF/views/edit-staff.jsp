<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Edit Staff | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <%-- LEFT: sidebar (Staff nav item stays highlighted) --%>
    <c:set var="active" value="staff" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <%-- RIGHT: top bar + content --%>
    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Add Staff"/>
        <jsp:param name="pageSubtitle" value="Create a new team member"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <%-- ---- Back link ---- --%>
        <a href="${pageContext.request.contextPath}/staffs"
           class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700 mb-4">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
          Back to Staff
        </a>

        <div class="max-w-2xl">
          <h2 class="text-2xl font-bold text-slate-800 mb-1">Edit Staff</h2>
          <p class="text-sm text-slate-400 mb-6">Fill in the details to edit the staff member.</p>

          <%-- ---- OPTIONAL: server-side error message ----
               In your servlet: request.setAttribute("error", "..."); then forward back here. --%>
          <c:if test="${not empty error}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-rose-50 border border-rose-100 text-sm text-rose-700">
              ${error}
            </div>
          </c:if>

          <%-- ============================================================
               THE FORM
               - method="post"  -> read fields with request.getParameter(...)
               - action points to the servlet you'll build for inserting.
               Each input's name is what you read on the server:
                 name, email, password, role, status
          ============================================================= --%>
          <c:if test="${not empty staff}">
            <form action="${pageContext.request.contextPath}/staffs/edit?id=${staff.id}" method="post"
                    class="bg-white rounded-xl border border-gray-200 p-6 space-y-5">

                <%-- Full name --%>
                <div>
                <label for="name" class="block text-sm font-medium text-slate-700 mb-1">Full Name</label>
                <input type="text" id="name" name="name" value="${staff.name}" required
                        placeholder="e.g. John Doe"
                        value="${param.name}"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
                </div>

                <%-- Email --%>
                <div>
                <label for="email" class="block text-sm font-medium text-slate-700 mb-1">Email</label>
                <input type="email" id="email" name="email" value="${staff.email}" required
                        placeholder="name@gmail.com"
                        value="${param.email}"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
                </div>

                <%-- Password (you will bcrypt-hash this before storing) --%>
                <div>
                    <label for="password" class="block text-sm font-medium text-slate-700 mb-1">Password</label>
                    <input type="password" id="password" name="password" minlength="6"
                            pattern="(?=.*[A-Za-z])(?=.*\d).{6,}|^$"
                            placeholder="Leave empty to keep current password, or enter new one"
                            class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
                    <p class="text-xs text-slate-400 mt-1">Leave empty to keep current password. If updating, use at least 6 characters with letters and numbers.</p>
                    <c:if test="${not empty passwordError}">
                        <p class="text-xs text-rose-600 mt-1">${passwordError}</p>
                    </c:if>
                </div>

                <%-- Role isn't editable - every staff record is role="staff". --%>

                <%-- Status. Matches the values your table colours on. --%>
                <div>
                    <label for="status" class="block text-sm font-medium text-slate-700 mb-1">Status</label>
                    <select id="status" name="status"
                            class="w-full sm:w-1/2 px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                        <option value="active" <c:if test="${staff.status == 'active'}">selected</c:if>>Active</option>
                        <option value="leave" <c:if test="${staff.status == 'leave'}">selected</c:if>>On Leave</option>
                        <option value="restricted" <c:if test="${staff.status == 'restricted'}">selected</c:if>>Restricted</option>
                    </select>
                </div>

                <%-- ---- Buttons ---- --%>
                <div class="flex items-center justify-end gap-3 pt-2">
                <a href="${pageContext.request.contextPath}/staffs"
                    class="px-4 py-2 rounded-lg border border-gray-300 text-sm font-medium text-slate-600 hover:bg-gray-50">
                    Cancel
                </a>
                <button type="submit"
                        class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">
                    Save Staff
                </button>
                </div>
            </form>
          </c:if>
        </div>

      </main>
    </div>
  </div>
</body>
</html>
