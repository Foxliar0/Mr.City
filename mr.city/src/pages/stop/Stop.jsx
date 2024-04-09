import React, { useEffect, useState } from "react";
import "./stop.scss";
import {
  Box,
  Button,
  TextField,
  Card,
  CardContent,
  FormControl,
  Stack,
  InputLabel,
  Select,
  MenuItem,
} from "@mui/material";
import Typography from "@mui/material/Typography";
import dayjs from "dayjs";
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  getDocs,
} from "firebase/firestore";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { db } from "../../config/firebase";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DemoContainer, DemoItem } from "@mui/x-date-pickers/internals/demo";
import { TimePicker } from "@mui/x-date-pickers/TimePicker";

const fiveAM = dayjs().set("hour", 5).startOf("hour");
const nineAM = dayjs().set("hour", 9).startOf("hour");

const Setstop = () => {

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

  const fetchDataa = async (id) => {
    setShowlocation('');
    console.log(id);
    const querySnapshot = await getDocs(collection(db, "Location").where('district', '==', id));
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
    setLocation(joinedData);
  };

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
  };

  useEffect(() => {
    fetchData();
    fetchDistrict();
  }, []);  
    
  return (
    <Box className="stop">
      <Box className="stopcontainer">
        <Stack direction="column" justifyContent="center" alignItems="center" width={950} spacing={2} sx={{ mt: 2 }} >
        <Box
        className="abcd"
          component="form"
          sx={{
            "& > :not(style)": { m: 3, width: "25ch" },
          }}
          noValidate
          autoComplete="off"
        >
              <Box className="boxz">
            <Card sx={{ width: "500px" }}>
              <CardContent style={{ border: '4px solid #ccc'}}>
              <Typography variant="h7" gutterBottom className="typo">
                  From
                </Typography>
                <Stack spacing={2} sx={{ mt: 2 }} direction="row">
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
                </Stack>
                <Stack spacing={2} sx={{ mt: 2 }} direction="row">
                  <FormControl fullWidth>
                    <InputLabel id="demo-simple-select-label">
                      Location
                    </InputLabel>
                    <Select
                      labelId="demo-simple-select-label"
                      id="demo-simple-select"
                      label="Location"
                      onChange={(e) => setLocation(e.target.value)}
                    >
                       {showlocation.map((row, key) => (
                          <MenuItem key={key} value={row.Id}>
                            {row.location}
                          </MenuItem>
                        ))}
                    </Select>
                  </FormControl>
                </Stack>
                <Stack spacing={2} sx={{ mt: 5 }} direction="row">
                <Typography variant="h7" gutterBottom>
                  To
                </Typography>
                </Stack>
                <Stack spacing={2} sx={{ mt: 2 }} direction="row">
                  <FormControl fullWidth>
                    <InputLabel id="demo-simple-select-label">
                      District
                    </InputLabel>
                    <Select
                      labelId="demo-simple-select-label"
                      id="demo-simple-select"
                      label="District"
                      onChange={(e) => {setDistrict(e.target.value);
                      fetchDataa(e.target.value)}
                      }
                      value={district}
                    >
                           {showdistrict.map((row, key) => (
                          <MenuItem key={key} value={row.Id}>
                            {row.district}
                          </MenuItem>
                        ))}
                    </Select>
                  </FormControl>
                </Stack>
                <Stack spacing={2} sx={{ mt: 2 }} direction="row">
                  <FormControl fullWidth>
                    <InputLabel id="demo-simple-select-label">
                      Location
                    </InputLabel>
                    <Select
                      labelId="demo-simple-select-label"
                      id="demo-simple-select"
                      label="Location"
                      onChange={(e) => setLocation(e.target.value)}
                    >
                           {showlocation.map((row, key) => (
                          <MenuItem key={key} value={row.Id}>
                            {row.location}
                          </MenuItem>
                        ))}
                    </Select>
                        <Stack spacing={2} sx={{ mt: 5 }} direction="row">
                  <FormControl fullWidth>
                    <InputLabel id="demo-simple-select-label">
                      Route
                    </InputLabel>
                    <Select
                      labelId="demo-simple-select-label"
                      id="demo-simple-select"
                      label="Route"
                    ></Select>
                  </FormControl>
                </Stack>
                <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                <LocalizationProvider dateAdapter={AdapterDayjs}>
                  <DemoContainer components={["TimePicker"]}>
                    <DemoItem label="Time">
                      <TimePicker defaultValue={fiveAM} minTime={nineAM} />
                    </DemoItem>
                  </DemoContainer>
                </LocalizationProvider>
                </Stack>
                <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                <TextField
                  id="outlined-basic"
                  label="Kilometer"
                  variant="outlined"
                />
                </Stack>
                <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                <Typography variant="h7" gutterBottom>
                    Destination
                </Typography>
                </Stack>
                    <Stack spacing={2} sx={{ mt: 2 }} direction="row">
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
                </Stack>
                <Stack spacing={2} sx={{ mt: 2 }} direction="row">
                  <FormControl fullWidth>
                    <InputLabel id="demo-simple-select-label">
                      Location
                    </InputLabel>
                    <Select
                      labelId="demo-simple-select-label"
                      id="demo-simple-select"
                      label="Location"
                      onChange={(e) => setLocation(e.target.value)}
                    >
                           {showlocation.map((row, key) => (
                          <MenuItem key={key} value={row.Id}>
                            {row.location}
                          </MenuItem>
                        ))}
                    </Select>
                  </FormControl>
                </Stack>
                <Stack spacing={2} sx={{ mt: 4 }} direction="row" className=" button">
                    <Button variant="contained">Sumbit</Button>
                    </Stack>
                  </FormControl>
                </Stack>
              </CardContent>
            </Card>
          </Box>
        </Box>
        </Stack>
      </Box>
    </Box>
  );
};

export default Setstop;
