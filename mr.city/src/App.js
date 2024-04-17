import Login from "./pages/login/Login";
import { Routes, Route } from "react-router-dom";
import AdminRoutes from "./AdminRoutes";

function App() {
  return (
    <Routes>
      <Route path="/dashboard/*" element={<AdminRoutes />} />
      <Route path="/" element={<Login />} />
    </Routes>
  );
}

export default App;
