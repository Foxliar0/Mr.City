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
import "./type.scss";
import Typography from "@mui/material/Typography";
import { db } from "../../config/firebase";
import { addDoc, collection, deleteDoc, doc, getDocs } from "firebase/firestore";
import DeleteIcon from "@mui/icons-material/Delete";
import UpdateIcon from "@mui/icons-material/Update";

const Type = () => {
  const [type, setType] = useState("");
  const [showtype, setShowtype] = useState([])

  const submit = async () => {
    console.log(type);
    try {
      await addDoc(collection(db, "Type"), {
        type,
      });
      setType("");
      alert('Successfully Added')
    } catch (error) {
      console.log(error);
      alert('Successfully Failed')
    }
    
  };

  const fetchData = async () => {
    const querySnapshot = await getDocs(collection(db, "Type"));
    const querySnapshotData = querySnapshot.docs.map((doc) => ({
      Id: doc.id,
      ...doc.data(),
    }));
    setShowtype(querySnapshotData);
    console.log(querySnapshotData);
  };

  const deleteData = async (Id) => {
    try {
      await deleteDoc(doc(db, "Type", Id));
    fetchData();
    alert('Successfully Deleted')
    } catch (error) {
    alert('Delete Failed')
      console.log(error);
    }
    
  };

  useEffect(() => {
    fetchData();
  }, []);


  return (
    <Box className="type">
      <Box className="typecontainer">
        <Box className='boxA'>
          <Card sx={{ width: "500px" }} style={{ border: '4px solid #ccc'}}>
            <CardContent>
              <Typography variant="h3" gutterBottom>
                Add Type
              </Typography>
              <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                <TextField
                  id="outlined-basic"
                  label="Outlined"
                  variant="outlined"
                  onChange={(e) => setType(e.target.value)}
                />
                <Button variant="contained" onClick={() => submit()}>
                  Contained
                </Button>
              </Stack>
            </CardContent>
          </Card>
        </Box>
        <Box sx={{ width: "100%" }} style={{ border: '4px solid #ccc'}}> 
          <TableContainer component={Paper} sx={{ marginTop: 5 }}>
            <Table sx={{ minWidth: 650 }} aria-label="simple table">
              <TableHead>
                <TableRow>
                  <TableCell>Sl.No</TableCell>
                  <TableCell align="center">Type</TableCell>
                  <TableCell align="center" colSpan={2}>
                    Action
                  </TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {showtype.map((row, key) => (
                  <TableRow
                    sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                    key={key}
                  >
                    <TableCell component="th" scope="row">
                      {key + 1}
                    </TableCell>
                    <TableCell align="center">{row.type}</TableCell>
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
      </Box>
    </Box>
  );
};

export default Type;
