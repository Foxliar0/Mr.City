import React, { useEffect, useState } from "react";
import {
  Box,
  Button,
  Card,
  CardContent,
  IconButton,
  Paper,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TextField,
} from "@mui/material";
import "./district.scss";
import Typography from "@mui/material/Typography";
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  getDocs,
} from "firebase/firestore";
import { db } from "../../config/firebase";
import DeleteIcon from "@mui/icons-material/Delete";
import UpdateIcon from "@mui/icons-material/Update";

const District = () => {
  const [district, setDistrict] = useState("");
  const [showdistrict, setShowdistrict] = useState([]);
  const submit = async () => {
    console.log(district);
    try {
      await addDoc(collection(db, "District"), {
        district,
      });
      setDistrict("");
      alert("Successfullly Added");
    } catch (error) {
      console.log(error);
      alert("Successfully Failed");
    }
  };
  const fetchData = async () => {
    const querySnapshot = await getDocs(collection(db, "District"));
    const querySnapshotData = querySnapshot.docs.map((doc) => ({
      Id: doc.id,
      ...doc.data(),
    }));
    setShowdistrict(querySnapshotData);
    console.log(querySnapshotData);
  };

  const deleteData = async (Id) => {
    try {
      await deleteDoc(doc(db, "District", Id));
      fetchData();
      alert("Sucessfully Deleted");
    } catch (error) {
      alert("Delete Failed");
      console.log(error);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);
  return (
    <Box className="district">
      <Box className="discontainer">
        <Box className="boxb">
          <Card sx={{ width: "500px" }} style={{ border: '4px solid #ccc'}}>
            <CardContent>
              <Typography variant="h4" gutterBottom>
                District
              </Typography>
              <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                <TextField
                  id="outlined-basic"
                  label="Add district"
                  variant="outlined"
                  onChange={(e) => setDistrict(e.target.value)}
                />
                <Button variant="contained" onClick={() => submit()}>
                  submit
                </Button>
              </Stack>
            </CardContent>
          </Card>
        </Box>
        <Stack spacing={2} sx={{ mt: 2 }} direction="row">
        <Box sx={{ width: "100%" }} style={{ border: '4px solid #ccc'}}>
          <TableContainer component={Paper} sx={{ marginTop: 5 }}>
            <Table sx={{ minWidth: 650 }} aria-label="simple table">
              <TableHead>
                <TableRow>
                  <TableCell>S1.No</TableCell>
                  <TableCell align="center">District</TableCell>
                  <TableCell align="center" colSpan={2}>
                    Action
                  </TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {showdistrict.map((row, key) => (
                  <TableRow
                    sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                    key={key}
                  >
                    <TableCell component="th" scope="row">
                      {key + 1}
                    </TableCell>
                    <TableCell align="center">{row.district}</TableCell>
                    <TableCell align="center">
                      <IconButton
                        aria-label="delete"
                        color="primary"
                        onClick={() => deleteData(row.Id)}
                      >
                        <DeleteIcon />
                      </IconButton>
                    </TableCell>
                    <TableCell align="center">
                      <IconButton
                        aria-label="update"
                        color="primary"
                        // onClick={() => updateData(row.Id)}
                      >
                        <UpdateIcon />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Box>
        </Stack>
      </Box>
    </Box>
  );
};

export default District;
