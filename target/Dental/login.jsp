<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Sunrise Dental</title>

    <!-- tailwind cdn -->
    <script src="https://cdn.tailwindcss.com"></script>

</head>
<body>

        <main class="flex flex-col items-center justify-center py-4 px-4 md:px-8 lg:min-h-screen">
   <div class="grid items-center gap-12 max-w-lg lg:grid-cols-2 lg:max-w-6xl">
      <div>
         <h2 class="text-4xl font-bold text-slate-900 !leading-tight lg:text-5xl">
            Seamless Login for Exclusive Access
         </h2>
         <p class="text-base mt-6 text-slate-600 leading-relaxed">Immerse yourself in a hassle-free
            login journey with our intuitively designed login form. Effortlessly access your account.</p>

      </div>

      <div class="max-w-md lg:ml-auto w-full">
         <h1 class="text-slate-900 text-3xl font-bold mb-10">
            Sign in
         </h1>

         <form class="space-y-6">
            <div>
               <label for="email"
                  class="mb-2 text-slate-900 font-medium text-sm inline-block">Email</label>
               <input type="email" id="email" name="email" placeholder="john@readymadeui.com" required
                  class="px-3 py-2.5 text-sm text-slate-900 rounded-md bg-white w-full outline-1 -outline-offset-1 outline-slate-300 focus:outline-2 focus:-outline-offset-2 focus:outline-blue-600" />
            </div>
            <div>
               <label for="password"
                  class="mb-2 text-slate-900 font-medium text-sm inline-block">Password</label>
               <input type="password" id="password" name="password" placeholder="••••••••" required
                  class="px-3 py-2.5 text-sm text-slate-900 rounded-md bg-white w-full outline-1 -outline-offset-1 outline-slate-300 focus:outline-2 focus:-outline-offset-2 focus:outline-blue-600" />
            </div>

            <div class="flex items-start flex-wrap gap-2">
               <label class="flex items-center group has-[input:checked]:text-slate-900">
                  <input id="remember" name="remember" type="checkbox" required class="sr-only" />
                  <!-- Custom box -->
                  <span class="flex h-4 w-4 shrink-0 items-center justify-center rounded outline-1 outline-slate-300 bg-white group-has-[input:checked]:bg-blue-600 group-has-[input:checked]:outline-blue-600 group-focus-within:outline-2 group-focus-within:outline-blue-600" aria-hidden="true">
                     <!-- Checkmark -->
                     <svg class="size-3 text-white opacity-0 group-has-[input:checked]:opacity-100" viewBox="0 0 12 10"
                        fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M1 5l3 3 7-7" />
                     </svg>
                  </span>
                  <span class="ml-3 text-sm text-slate-700">
                     Remember me
                  </span>
               </label>

            </div>
            <button type="submit"
               class="w-full py-2 px-3.5 text-sm rounded-md font-semibold cursor-pointer text-white border border-blue-600 bg-blue-600 hover:bg-blue-700 transition-all focus:outline-none focus-visible:ring-2 focus-visible:ring-blue-500">
               Sign in</button>
         </form>

      </div>
   </div>
</main>

</body>
</html>