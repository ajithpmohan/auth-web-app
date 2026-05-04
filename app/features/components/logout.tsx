"use client";

import { useRouter } from "next/navigation";
import { deleteCookie } from "cookies-next/client";

export default function LogoutButton() {
  const router = useRouter();

  const handleLogout = () => {
    deleteCookie("authUser", { path: "/" });
    router.push("/login");
    router.refresh();
  };

  return (
    <button
      onClick={handleLogout}
      className="bg-blue-500 px-4 py-2 rounded-lg hover:bg-blue-600 transition"
    >
      Logout
    </button>
  );
}
