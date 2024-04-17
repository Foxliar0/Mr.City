import "./sidebar.scss";
import PersonIcon from "@mui/icons-material/Person";
import AddLocationAltIcon from "@mui/icons-material/AddLocationAlt";
import MyLocationIcon from "@mui/icons-material/MyLocation";
import AddIcon from "@mui/icons-material/Add";
import LogoutIcon from '@mui/icons-material/Logout';
import NoteIcon from "@mui/icons-material/Note";
import RouteIcon from "@mui/icons-material/Route";
import DepartureBoardIcon from "@mui/icons-material/DepartureBoard";
import HailIcon from "@mui/icons-material/Hail";
import { Link } from "react-router-dom";
const Sidebar = () => {
  return (
    <div className="sidebar">
      <div className="top">
        <span className="logo">Mr City</span>
      </div>
      <hr></hr>
      <div className="center">
        <ul>
          <p className="title">Lists</p>
          <Link to={"List"} style={{ textDecoration: "none" }}>
            <li>
              <PersonIcon className="icon" />

              <span>Users List</span>
            </li>
          </Link>
          <Link to={"request"} style={{ textDecoration: "none" }}>
            <li>
              <NoteIcon className="icon" />
              <span>Request List</span>
            </li>
          </Link>
          <p className="title">Add Place</p>
          <Link to={"district"} style={{ textDecoration: "none" }}>
            <li>
              <AddLocationAltIcon className="icon" />
              <span>District</span>
            </li>
          </Link>
          <Link to={"location"} style={{ textDecoration: "none" }}>
            <li>
              <MyLocationIcon className="icon" />
              <span>Location</span>
            </li>
          </Link>
          <Link to={"type"} style={{ textDecoration: "none" }}>
            <li>
              <AddIcon className="icon" />
              <span>Type</span>
            </li> 
          </Link>
          <p className="title">Bus Route</p>
          <Link to={"route"} style={{ textDecoration: "none" }}>
            <li>
              <RouteIcon className="icon" />
              <span>Route</span>
            </li>
          </Link>
          <Link to={"schedule"} style={{ textDecoration: "none" }}>
            <li>
              <DepartureBoardIcon className="icon" />
              <span>Schedule</span>
            </li>
          </Link>
          <Link to={"stop"} style={{ textDecoration: "none" }}>
            <li>
              <HailIcon className="icon" />
              <span>Stop</span>
            </li>
          </Link>
          <p className="title">Log Out</p>
          <Link to={"/"} style={{ textDecoration: "none" }}>
            <li>
              <LogoutIcon className="icon" />
              <span>Log Out</span>
            </li>
          </Link>
        </ul>
      </div>
    </div>
  );
};

export default Sidebar;
