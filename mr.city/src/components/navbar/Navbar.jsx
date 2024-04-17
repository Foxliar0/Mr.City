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
        </div>
      </div>
    </div>
  );
};

export default Navbar;
