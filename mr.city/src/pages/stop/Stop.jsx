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
  TableContainer,
  Table,
  TableHead,
  TableRow,
  TableCell,
  TableBody,
  IconButton,
  Paper,
} from "@mui/material";
import Typography from "@mui/material/Typography";
import DeleteIcon from "@mui/icons-material/Delete";

import dayjs from "dayjs";
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  getDocs,
  query,
  where,
} from "firebase/firestore";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { db } from "../../config/firebase";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DemoContainer, DemoItem } from "@mui/x-date-pickers/internals/demo";
import { TimePicker } from "@mui/x-date-pickers/TimePicker";

const fiveAM = dayjs().set("hour", 5).startOf("hour");
const nineAM = dayjs().set("hour", 9).startOf("hour");

const Setstop = () => {
  const [locationOne, setLocationOne] = useState("");
  const [locationTwo, setLocationTwo] = useState("");
  const [locationTree, setLocationTree] = useState("");
  const [showlocation, setShowlocation] = useState([]);
  const [showdistrict, setShowDistrict] = useState([]);
  const [showroutes, setShowRoutes] = useState([]);
  const [showData, setShowData] = useState([]);
  const [districtOne, setDistrictOne] = useState("");
  const [routes, setRoutes] = useState("");
  const [districtTwo, setDistrictTwo] = useState("");
  const [districtThree, setDistrictThree] = useState("");
  const [time, setTime] = useState("");
  const [kilometer, setKilometer] = useState("");

  const submit = async () => {
    try {
      await addDoc(collection(db, "stop"), {
        routes,
        kilometer,
        time,
        destination: locationTree,
      });
      setLocationOne("");
      setLocationTwo("");
      setLocationTree("");
      setDistrictOne("");
      setDistrictTwo("");
      setDistrictThree("");
      setKilometer("");
      setTime("");

      alert("Successfully Added");
      fetchData();
    } catch (error) {
      alert("Successfully failed");
    }
  };

  
  const fetchData = async () => {
    const stopSnapshot = await getDocs(collection(db, "stop"));
    const stopData = stopSnapshot.docs.map((doc) => ({
      stop_id: doc.id,
      ...doc.data(),
    }));
    const routesSnapshot = await getDocs(collection(db, "routes"));
    const routesData = routesSnapshot.docs.map((doc) => ({
      routes_id: doc.id,
      ...doc.data(),
    }));
    const locationSnapshot = await getDocs(collection(db, "Location"));
    const locationData = locationSnapshot.docs.map((doc) => ({
      location_id: doc.id,
      ...doc.data(),
    }));

    const joinedData = stopData
      .map((stop) => ({
        ...stop,
        routesInfo: routesData.find(
          (route) => route.routes_id === stop.routes
        ),
        destinationInfo: locationData.find(
          (location) => location.location_id === stop.destination
        ),
      }))
      .filter((stop) => stop.routesInfo && stop.destinationInfo);

    setShowData(joinedData);
  };

  const deleteData = async (Id) => {
    try {
      await deleteDoc(doc(db, "stop", Id));
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

  const fetchLocation = async (id) => {
    console.log(id);
    const querySnapshot = await getDocs(
      query(collection(db, "Location"), where("district", "==", id))
    );
    const querySnapshotData = querySnapshot.docs.map((doc) => ({
      Id: doc.id,
      ...doc.data(),
    }));
    console.log(querySnapshotData);
    setShowlocation(querySnapshotData);
  };

  useEffect(() => {
    const fetchData = async () => {
      if (!locationOne || !locationTwo) return;

      try {
        const querySnapshot = await getDocs(
          query(
            collection(db, "routes"),
            where("fromLocation", "==", locationOne),
            where("toLocation", "==", locationTwo)
          )
        );
        const querySnapshotData = querySnapshot.docs.map((doc) => ({
          Id: doc.id,
          ...doc.data(),
        }));
        console.log(querySnapshotData);
        setShowRoutes(querySnapshotData);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, [locationOne, locationTwo]);

  useEffect(() => {
    fetchData();
    fetchDistrict();
  }, []);

  return (
    <>
      <Box className="stop">
        <Box className="stopcontainer">
          <Stack
            direction="column"
            justifyContent="center"
            alignItems="center"
            width={950}
            spacing={2}
            sx={{ mt: 2 }}
          >
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
                  <CardContent style={{ border: "4px solid #ccc" }}>
                    <Typography variant="h7" gutterBottom className="typo">
                    </Typography>
                    <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                      <Typography variant="h7" gutterBottom className="typo">
                        From
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
                          onChange={(e) => {
                            setDistrictOne(e.target.value);
                            fetchLocation(e.target.value);
                          }}
                          value={districtOne}
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
                          onChange={(event) =>
                            setLocationOne(event.target.value)
                          }
                          value={locationOne}
                        >
                          {showlocation.map((row, key) => (
                            <MenuItem key={key} value={row.Id}>
                              {row.location}
                            </MenuItem>
                          ))}
                        </Select>
                      </FormControl>
                    </Stack>
                    <Stack spacing={2} sx={{ mt: 4 }} direction="row">
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
                          onChange={(e) => {
                            setDistrictTwo(e.target.value);
                            fetchLocation(e.target.value);
                          }}
                          value={districtTwo}
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
                          onChange={(event) =>
                            setLocationTwo(event.target.value)
                          }
                          value={locationTwo}
                        >
                          {showlocation.map((row, key) => (
                            <MenuItem key={key} value={row.Id}>
                              {row.location}
                            </MenuItem>
                          ))}
                        </Select>
                      </FormControl>
                    </Stack>
                    <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                      <FormControl fullWidth>
                        <InputLabel id="demo-simple-select-label">
                          Route
                        </InputLabel>
                        <Select
                          labelId="demo-simple-select-label"
                          id="demo-simple-select"
                          label="Route"
                          onChange={(event) => setRoutes(event.target.value)}
                          value={routes}
                        >
                          {showroutes.map((row, key) => (
                            <MenuItem key={key} value={row.Id}>
                              {row.name}
                            </MenuItem>
                          ))}
                        </Select>
                      </FormControl>
                    </Stack>
                    <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                      <TextField
                        id="outlined-basic"
                        label="Time"
                        type="time"
                        variant="outlined"
                        onChange={(event) => setTime(event.target.value)}
                        value={time}
                      />
                    </Stack>

                    <Stack spacing={2} sx={{ mt: 4 }} direction="row">
                      <TextField
                        id="outlined-basic"
                        label="Kilometer"
                        variant="outlined"
                        onChange={(event) => setKilometer(event.target.value)}
                        value={kilometer}
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
                          onChange={(e) => {
                            setDistrictThree(e.target.value);
                            fetchLocation(e.target.value);
                          }}
                          value={districtThree}
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
                          onChange={(e) => setLocationTree(e.target.value)}
                          value={locationTree}
                        >
                          {showlocation.map((row, key) => (
                            <MenuItem key={key} value={row.Id}>
                              {row.location}
                            </MenuItem>
                          ))}
                        </Select>
                      </FormControl>
                    </Stack>
                    <Stack
                      spacing={2}
                      sx={{ mt: 4 }}
                      direction="row"
                      className=" button"
                    >
                      <Button variant="contained" onClick={submit}>
                        Sumbit
                      </Button>
                    </Stack>
                  </CardContent>
                </Card>
              </Box>
            </Box>
          </Stack>
        </Box>
      </Box>

      <Box sx={{ width: "100%" }} style={{ border: "4px solid #ccc" }}>
        <TableContainer component={Paper} sx={{ marginTop: 5 }}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
              <TableRow>
                <TableCell>S1.no</TableCell>
                <TableCell align="center">Time</TableCell>
                <TableCell align="center">Destionation</TableCell>
                <TableCell align="center">Route</TableCell>
                <TableCell align="center">Kilometer</TableCell>
                <TableCell align="center" colSpan={2}>
                  Action
                </TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {showData.map((row, key) => (
                <TableRow
                  sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                  key={key}
                >
                  <TableCell component="th" scope="row">
                    {key + 1}
                  </TableCell>
                  <TableCell align="center">{row.time}</TableCell>
                  <TableCell align="center">{row.destinationInfo.location}</TableCell>
                  <TableCell align="center">{row.routesInfo.name}</TableCell>
                  <TableCell align="center">{row.kilometer}</TableCell>

                  <TableCell align="center">
                    <IconButton
                      aria-label="delete"
                      color="primary"
                      onClick={() => deleteData(row.stop_id)}
                    >
                      <DeleteIcon />
                    </IconButton>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Box>
    </>
  );
};

export default Setstop;
