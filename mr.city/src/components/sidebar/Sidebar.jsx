import "./sidebar.scss";
import DashboardIcon from "@mui/icons-material/Dashboard";
import PersonIcon from "@mui/icons-material/Person";
import LocationOnIcon from "@mui/icons-material/LocationOn";
import AccountCircleIcon from "@mui/icons-material/AccountCircle";
import PersonAddIcon from "@mui/icons-material/PersonAdd";
import CircleNotificationsIcon from "@mui/icons-material/CircleNotifications";
import LoginIcon from "@mui/icons-material/Login";
import AppRegistrationIcon from "@mui/icons-material/AppRegistration";
import AddLocationAltIcon from "@mui/icons-material/AddLocationAlt";
import SettingsIcon from "@mui/icons-material/Settings";
import NoteIcon from "@mui/icons-material/Note";
const Sidebar = () => {
  return (
    <div className="sidebar">
      <div className="top">
        <span className="logo">Mr City</span>
      </div>
      <hr></hr>
      <div className="center">
        <ul>
          <p className="title">Main</p>
          <li>
            <DashboardIcon className="icon" />
            <span>Dashboard</span>
          </li>
          <li>
            <PersonIcon className="icon" />
            <span>Users</span>
          </li>
          <li>
            <LocationOnIcon className="icon" />
            <span>map</span>
          </li>
          <p className="title">Edit</p>
          <li>
            <AccountCircleIcon className="icon" />
            <span>My Profile</span>
          </li>
          <li>
            <PersonAddIcon className="icon" />
            <span>Edit Profile</span>
          </li>
          <li>
            <CircleNotificationsIcon className="icon" />
            <span>Notification</span>
          </li>
          <p className="title">In And Out</p>
          <li>
            <LoginIcon className="icon" />
            <span>Log In</span>
          </li>
          <li>
            <AppRegistrationIcon className="icon" />
            <span>Registration</span>
          </li>
          <p className="title">Service</p>
          <li>
            <NoteIcon className="icon" />
            <span>Request</span>
          </li>
          <li>
            <AddLocationAltIcon className="icon" />
            <span>App Place</span>
          </li>
          <li>
            <SettingsIcon className="icon" />
            <span>Settings</span>
          </li>
        </ul>
      </div>
      <div className="bottom">
        <div className="coloroption"></div>
        <div className="coloroption"></div>
      </div>
    </div>
  );
};

export default Sidebar;
