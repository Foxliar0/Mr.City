import Home from "./pages/home/Home";
import Login from "./pages/login/Login";
import List from "./pages/list/List";
import Single from "./pages/single/Single";
import New from "./pages/request/Request";
import { Routes, Route } from "react-router-dom";
import Type from "./pages/type/Type";
import District from "./pages/district/District";
import Location from "./pages/location/Location";
import Manageroute from "./pages/route/Route";
import Setstop from "./pages/stop/Stop";
import RouteSchedule from "./pages/schedule/Schedule";
import Request from "./pages/request/Request";
import Sidebar from "./components/sidebar/Sidebar";
import Navbar from "./components/navbar/Navbar";
import { Box } from "@mui/material";
import { Place } from "@mui/icons-material";

function AdminRoutes() {
  return (
    <div className="app">
      <div className="home">
        <Sidebar />
        <div className="homecontainer">
          <Navbar />
          <Box className="widgets" sx={{flex:6,flexDirection:'column'}}>
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/list" element={<List />} />
              <Route path="UserId" element={<Single />} />
              <Route path="New" element={<New />} />
              <Route path="type" element={<Type />} />  
              <Route path="district" element={<District />} />
              <Route path="/location" element={<Location />} />
              <Route path="route" element={<Manageroute />} />
              <Route path="schedule" element={<RouteSchedule />} />
              <Route path="stop" element={<Setstop />} />
              <Route path="request" element={<Request />} />
              <Route path="place" element={<Place/>} />
            </Routes>
          </Box>
        </div>
      </div>
    </div>
  );
}

export default AdminRoutes;
