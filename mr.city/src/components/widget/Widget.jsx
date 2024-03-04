import "./widget.scss"
import KeyboardArrowUpIcon from '@mui/icons-material/KeyboardArrowUp';
import PersonIcon from '@mui/icons-material/Person';

const Widget = () => {
  return (
    <div className="widget">
      <div className="left">
        <div className="title">Users</div>
        <div className="counter">9845623</div>
        <div className="link">See all users</div>
      </div>
      <div className="right">
        <div className="persentage positive">
          <KeyboardArrowUpIcon/>
          20% 
          </div>
          <PersonIcon className="icon"/>
      </div>
    </div>
  );
};

export default Widget;
