import React, { useEffect, useState } from "react";
import "./route.scss";
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
  TableCell,
  IconButton,
  TableContainer,
  Table,
  TableHead,
  TableRow,
  Paper,
  TableBody,
} from "@mui/material";
import Typography from "@mui/material/Typography";
import DeleteIcon from "@mui/icons-material/Delete";
import UpdateIcon from "@mui/icons-material/Update";
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  getDocs,
  query,
  where,
} from "firebase/firestore";
import { db } from "../../config/firebase";

const Manageroute = () => {
  const [locationOne, setLocationOne] = useState("");
  const [name, setName] = useState("");
  const [kilometer, setKilometer] = useState("");
  const [locationTwo, setLocationTwo] = useState("");
  const [showlocation, setShowlocation] = useState([]);
  const [showdistrict, setShowDistrict] = useState([]);
  const [showData, setShowData] = useState([]);
  const [districtOne, setDistrictOne] = useState("");
  const [districtTwo, setDistrictTwo] = useState("");

  const submit = async () => {
    try {
      await addDoc(collection(db, "routes"), {
        fromLocation: locationOne,
        toLocation: locationTwo,
        name,
        kilometer,
      });
      setLocationOne("");
      setLocationTwo("");
      setDistrictOne("");
      setDistrictTwo("");
      setKilometer("");
      setName("");
      alert("Successfully Added");
      // fetchData();
    } catch (error) {
      alert("Successfully failed");
    }
  };

  const fetchData = async () => {
    const routeSnapshot = await getDocs(collection(db, "routes"));
    const routeData = routeSnapshot.docs.map((doc) => ({
      route_id: doc.id,
      ...doc.data(),
    }));
    const locationSnapshot = await getDocs(collection(db, "Location"));
    const locationData = locationSnapshot.docs.map((doc) => ({
      location_id: doc.id,
      ...doc.data(),
    }));

    const joinedData = routeData
      .map((route) => ({
        ...route,
        fromLocationInfo: locationData.find(
          (location) => location.location_id === route.fromLocation
        ),
        toLocationInfo: locationData.find(
          (location) => location.location_id === route.toLocation
        ),
      }))
      .filter((route) => route.fromLocationInfo && route.toLocationInfo);

    setShowData(joinedData);
  };

  const deleteData = async (Id) => {
    try {
      await deleteDoc(doc(db, "routes", Id));
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
    fetchData();
    fetchDistrict();
  }, []);
  return (
    <>
      <Box className="route">
        <Box className="routecontainer">
          <Stack
            direction="column"
            justifyContent="center"
            alignItems="center"
            width={950}
            spacing={2}
            sx={{ mt: 2 }}
          >
            <Box
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
                    <TextField
                      id="outlined-basic"
                      label="Name"
                      variant="outlined"
                      onChange={(event) => setName(event.target.value)}
                      value={name}
                    />
                    <Stack spacing={2} sx={{ mt: 3 }} direction="row">
                      <TextField
                        id="outlined-basic"
                        label="Kilometer"
                        variant="outlined"
                        onChange={(event) => setKilometer(event.target.value)}
                        value={kilometer}
                      />
                    </Stack>
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
                        <Stack
                          spacing={2}
                          sx={{ mt: 3 }}
                          direction="row"
                          className="buttona"
                        >
                          <Button variant="contained" onClick={submit}>
                            Sumbit
                          </Button>
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
      <Box sx={{ width: "100%" }} style={{ border: "4px solid #ccc" }}>
        <TableContainer component={Paper} sx={{ marginTop: 5 }}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
              <TableRow>
                <TableCell>S1.no</TableCell>
                <TableCell align="center">Name</TableCell>
                <TableCell align="center">kilometer</TableCell>
                <TableCell align="center">FromLocation</TableCell>
                <TableCell align="center">ToLocation</TableCell>
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
                  <TableCell align="center">{row.name}</TableCell>
                  <TableCell align="center">{row.kilometer}</TableCell>
                  <TableCell align="center">
                    {row.fromLocationInfo.location}
                  </TableCell>
                  <TableCell align="center">
                    {row.toLocationInfo.location}
                  </TableCell>
                  <TableCell align="center">
                    <IconButton
                      aria-label="delete"
                      color="primary"
                      onClick={() => deleteData(row.route_id)}
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

export default Manageroute;
