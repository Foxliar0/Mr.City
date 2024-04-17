import "./request.scss";
import { Box } from "@mui/material";
import OfflinePinRoundedIcon from "@mui/icons-material/OfflinePinRounded";
import React, { useEffect, useState } from "react";
import CancelIcon from "@mui/icons-material/Cancel";
import { db } from "../../config/firebase";
import { collection, getDocs } from "firebase/firestore";
import { DataGrid } from "@mui/x-data-grid";
import { doc, updateDoc } from "firebase/firestore";

const Request = () => {
  const [rows, setRows] = useState([]);

  const columns = [
    { field: "index", headerName: "ID", flex: 0.1 },
    {
      field: "user id",
      headerName: "User ID",
      flex: 8,
      headerAlign: "center",
      align: "center",
    },
    {
      field: "location",
      headerName: "Location",
      flex: 5,
      headerAlign: "center",
      align: "center",
    },
    {
      field: "type",
      headerName: "Type",
      flex: 5,
      headerAlign: "center",
      align: "center",
    },
    {
      field: "place",
      headerName: "Place:",
      flex: 5,
      headerAlign: "center",
      align: "center",
    },
    {
      field: "details",
      headerName: "Details:",
      flex: 8,
      headerAlign: "center",
      align: "center",
    },
    {
      field: "status",
      headerName: "Status",
      flex: 2,
      headerAlign: "center",
      align: "center",
    },
    {
      field: "action",
      headerName: "Action",
      width: 100,
      renderCell: (params) => {
        return (
          <>
          {
            console.log(params)
          }
              <OfflinePinRoundedIcon
                className="requestListSelectgreen"
                onClick={() => acceptPlace(params.row.id)}
              />
         
            <CancelIcon
              className="requestListDeletered"
              onClick={() => cancelPlace(params.row.id)}
            />

          </>
        );
      },
    },
  ];

  const fetchData = async () => {
    const querySnapshot = await getDocs(collection(db, "place"));
    const querySnapshotData = querySnapshot.docs.map((doc, index) => ({
      id: doc.id,
      index: index + 1,
      ...doc.data(),
    }));
    setRows(querySnapshotData);
   
  };

  const acceptPlace = async (id) => {
    const acceptDocRef = doc(db, "place", id);
    await updateDoc(acceptDocRef, {
      status: 1,
    });

    fetchData();

  };

  const cancelPlace = async (id) => {
    const cancelDocRef = doc(db, "place", id);
    await updateDoc(cancelDocRef, {
      status: 2,
    });

    fetchData();

  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <Box className="request">
      <Box className="requestContainer">
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
      </Box>
    </Box>
  );
};

export default Request;
