import React, { useEffect, useState } from "react";
import "./location.scss";
import {
  Box,
  Button,
  Card,
  CardContent,
  FormControl,
  IconButton,
  InputLabel,
  MenuItem,
  Paper,
  Select,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TextField,
  useMediaQuery,
} from "@mui/material";
import "./location.scss";
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

const Location = () => {
  const [location, setLocation] = useState("");
  const [showlocation, setShowlocation] = useState([]);
  const [showdistrict, setShowDistrict] = useState([]);
  const [district, setDistrict] = useState("");
  const submit = async () => {
    console.log(location);
    try {
      await addDoc(collection(db, "Location"), {
        location,
        district,
      });
      setLocation("");
      alert("Successfully Added");
      fetchData();
    } catch (error) {
      alert("Successfully failed");
    }
  };

  const fetchDataa = async () => {
    const querySnapshot = await getDocs(collection(db, "Location"));
    const querySnapshotData = querySnapshot.docs.map((doc) => ({
      Id: doc.id,
      ...doc.data(),
    }));
    setShowlocation(querySnapshotData);
    console.log(querySnapshotData);
  };

  const fetchData = async () => {
    const locationSnashot = await getDocs(collection(db, "Location"));
    const locationData = locationSnashot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    const districtSnapshot = await getDocs(collection(db, "District"));
    const districtData = districtSnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    const joinedData = locationData
      .map((location) => ({
        ...location,
        districtInfo: districtData.find(
          (district) => district.id === location.district
        ),
      }))
      .filter(
        (location) => location.districtInfo && location.districtInfo.district
      );
      setShowlocation(joinedData);
      console.log(joinedData);
  }

  const deleteData = async (Id) => {
    try {
      await deleteDoc(doc(db, "Location", Id));
      fetchData();
      alert("Successfully Deleted");
    } catch (error) {
      alert("Delete Failed");
      console.log(error);
    }
  };

  const fetchDistrict = async () => {
    const querySnapshot = await getDocs(collection(db, "District"));
    const querySnapshotData = querySnapshot.docs.map((doc) => ({
      Id: doc.id,
      ...doc.data(),
    }));
    setShowDistrict(querySnapshotData);
    console.log(querySnapshotData);
  };

  useEffect(() => {
    fetchData();
    fetchDistrict();
  }, []);
  return (
    <Box className="location">
      <Box className="locatcontainer">
        <Box className="boxc">
          <Card sx={{ width: "500px" }} style={{ border: '4px solid #ccc'}}>
            <CardContent>
              <Typography variant="h4" gutterBottom>
                Enter Location
              </Typography>
              <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                <FormControl fullWidth>
                  <InputLabel id="demo-simple-select-label">
                    District
                  </InputLabel>
                  <Select
                    labelId="demo-simple-select-label"
                    id="demo-simple-select"
                    label="District"
                    onChange={(e) => setDistrict(e.target.value)}
                    value={district}
                  >
                    {showdistrict.map((row, key) => (
                      <MenuItem key={key} value={row.Id}>
                        {row.district}
                      </MenuItem>
                    ))}
                  </Select>
                </FormControl>

                <TextField
                  id="outlined-basic"
                  label="Add location"
                  variant="outlined"
                  onChange={(e) => setLocation(e.target.value)}
                />
                <Button variant="contained" onClick={() => submit()}>
                  Sumbit
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
                  <TableCell>S1.no</TableCell>
                  <TableCell align="center">District</TableCell>
                  <TableCell align="center" colSpan={2}>
                    Action
                  </TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {showlocation.map((row, key) => (
                  <TableRow
                    sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                    key={key}
                  >
                    <TableCell component="th" scope="row">
                      {key + 1}
                    </TableCell>
                    <TableCell align="center">{row.location}</TableCell>
                    <TableCell align="center">
                      <IconButton
                        aria-label="delete"
                        color="primary"
                        onClick={() => deleteData(row.id)}
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
        <Box></Box>
      </Box>
    </Box>
  );
};

export default Location;