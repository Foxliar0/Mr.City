import "./navbar.scss";
import SearchIcon from "@mui/icons-material/Search";
import LanguageIcon from "@mui/icons-material/Language";
import DarkModeIcon from "@mui/icons-material/DarkMode";
import CloseFullscreenIcon from "@mui/icons-material/CloseFullscreen";
import NotificationsOffIcon from "@mui/icons-material/NotificationsOff";
import ChatBubbleIcon from "@mui/icons-material/ChatBubble";
import ReorderIcon from "@mui/icons-material/Reorder";

const Navbar = () => {
  return (
    <div className="navbar">
      <div className="wrapper">
      <div className="search">
        <input type="text" placeholder="Search...." />
        <SearchIcon />
        </div>
        <div className="item">
          <div className="item">
            <LanguageIcon className="icon" />
            English
          </div>
          <div className="item">
            <DarkModeIcon className="icon" />
          </div>
          <div className="item">
            <CloseFullscreenIcon className="icon" />
          </div>
          <div className="item">
            <NotificationsOffIcon className="icon" />
            <div className="counter">1</div>
          </div>
          <div className="item">
            <ChatBubbleIcon className="icon" />
            <div className="counter">2</div>
          </div>
          <div className="item">
            <ReorderIcon className="icon" />
          </div>
          <div className="item">
            <img
            src="https://images.pexels.com/photos/17736421/pexels-photo-17736421/free-photo-of-close-up-of-a-little-cormorant.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
            alt=""
            className="avatar"
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default Navbar;
