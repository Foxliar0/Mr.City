import { Link } from "react-router-dom";
import "./navbar.scss";
import HomeIcon from '@mui/icons-material/Home';
const Navbar = () => {
  return (
    <div className="navbar">
      <div className="wrapper">
        <div className="item">
          <Link to={'dashboard'}>
        <div className="Aicon">
            <HomeIcon/>
          </div>
          </Link>
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
