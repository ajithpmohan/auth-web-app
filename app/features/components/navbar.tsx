import LogoutButton from "@/features/components/logout";
import { cookies } from "next/headers";
import Link from "next/link";

export default async function NavBar() {
  const cookieStore = await cookies();
  const cookieValue = cookieStore.get("authUser")?.value;
  const authUser = cookieValue ? JSON.parse(cookieValue) : null;

  return (
    <nav className="bg-gray-900 text-white px-6 py-4 shadow-md">
      <div className="max-w-6xl mx-auto flex items-center justify-between">
        {/* Logo / Brand */}
        <Link href="/" className="text-xl font-bold">
          Auth App
        </Link>

        {/* Navigation */}
        <ul className="flex items-center gap-6">
          {authUser?.isAuth ? (
            <>
              <li>
                <Link href="/" className="hover:text-gray-300 transition">
                  Dashboard
                </Link>
              </li>
              <li>
                <LogoutButton />
              </li>
            </>
          ) : (
            <>
              <li>
                <Link
                  href="/login"
                  className="bg-blue-500 px-4 py-2 rounded-lg hover:bg-blue-600 transition"
                >
                  Login
                </Link>
              </li>
            </>
          )}
        </ul>
      </div>
    </nav>
  );
}
