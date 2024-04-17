import Sidebar from "../../components/sidebar/Sidebar";
import Navbar from "../../components/navbar/Navbar";
import DeleteIcon from "@mui/icons-material/Delete";
import React, { useEffect, useState } from "react";
import "./list.scss";
import { DataGrid } from "@mui/x-data-grid";
import { db } from "../../config/firebase";
import { collection, getDocs } from "firebase/firestore";
import { Box } from "@mui/material";

const List = () => {
  const [rows, setRows] = useState([]);

  const columns = [
    { field: "index", headerName: "ID", flex: 1 },
    {
      field: "email",
      headerName: "Email ID",
      flex: 3,
      headerAlign: "center",
      align: "center",
    },
    {
      field: "name",
      headerName: "Name",
      flex: 3,
      headerAlign: "center",
      align: "center",
    },
    {
      field: "phone",
      headerName: "Phone no:",
      flex: 3,
      headerAlign: "center",
      align: "center",
    },
  ];

  const fetchData = async () => {
    const querySnapshot = await getDocs(collection(db, "users"));
    const querySnapshotData = querySnapshot.docs.map((doc, index) => ({
      id: doc.id,
      index: index + 1,
      ...doc.data(),
    }));
    setRows(querySnapshotData);
    console.log(querySnapshotData);
  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <div className="list">
      <Box >
        <DataGrid
          rows={rows}
          columns={columns}
          initialState={{
            pagination: {
              paginationModel: { page: 0, pageSize: 5 },
            },
          }}
          pageSizeOptions={[5, 10]}
        />
      </Box>
    </div>
  );
};

export default List;
