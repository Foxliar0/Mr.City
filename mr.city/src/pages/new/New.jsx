import { useState } from "react";
import Navbar from "../../components/navbar/Navbar";
import Sidebar from "../../components/sidebar/Sidebar";
import "./new.scss";
import FileOpenOutlinedIcon from '@mui/icons-material/FileOpenOutlined';

const New = () => {
  const[file,setFile] = useState("")
  return (
    <div className="new">
      <Sidebar />
      <div className="newContainer">
        <Navbar />
        <div className="top">
          <h1>Add New User</h1>
        </div>
        <div className="bottom">
          <div className="left">
            <img
              src={file ?URL.createObjectURL(file) : "https://images.pexels.com/photos/12082485/pexels-photo-12082485.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"}
              alt="/"
            />
          </div>
          <div className="right">
            <form>
              <div className="formInput">
                <label htmlFor="file">
                 Image:<FileOpenOutlinedIcon className="icon"/> 
                </label>
                <input type="file" id="file" onChange={e=>setFile(e.target.files[0])} style={{display:"none"}}/>
              </div>
              <div className="formInput">
                <label>Username</label>
                <input type="text" placeholder="john_doe" />
              </div>
              <div className="formInput">
                <label>name and Surname</label>
                <input type="text" placeholder="John doe" />
              </div>
              <div className="formInput">
                <label>Email</label>
                <input type="email" placeholder="johndoe@gmail.com" />
              </div>
              <div className="formInput">
                <label>Phone</label>
                <input type="text" placeholder="1234567890" />
              </div>
              <div className="formInput">
                <label>Password</label>
                <input type="password" />
              </div>
              <div className="formInput">
                <label>Address</label>
                <input type="text" placeholder="thrissur kerala 6805**" />
              </div>
              <div className="formInput">
                <label>Country</label>
                <input type="text" placeholder="India" />
              </div>
              <button>Send</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

export default New;
