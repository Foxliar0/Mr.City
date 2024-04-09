import Navbar from "../../components/navbar/Navbar"
import Sidebar from "../../components/sidebar/Sidebar"
import "./single.scss"

const Single = () => {
  
  return (
    <div className="single">
      <Sidebar/>
      <div className="singleContainer">
        <Navbar/>
        sidebar 
      </div>
    </div>
  )
}

export default Single;