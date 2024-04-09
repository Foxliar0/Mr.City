    export const userColumns = [
    { field: 'id', headerName: 'ID', width: 70 },
    { field:"user",headerName:"User", width: 230, renderCell: (params)=>{
        return(
            <div className="cellWithImg">
                <img className="cellImg" src={params.row.img} alt="avatar"/>
                {params.row.username}
            </div>
        ) 
    }
},
{
    field:"email", 
    headerName:"Email", 
    width: 230
},
{
    field:"age", 
    headerName:"Age", 
    width: 100
},
{
    field:"status", 
    headerName:"Status", 
    width: 160,
    renderCell:(params)=>{
        return(
            <div className={`cellWithStatus`}>
                {
                    params.row.status  
                }
            </div>
        )
    }

},
];
export const userRows = [
    {
        id: 1,
        username:"Snow",
        img:"https://images.pexels.com/photos/20374737/pexels-photo-20374737/free-photo-of-young-woman-in-a-brown-coat-standing-on-a-snowy-field.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        status:"active",
        email:"1snw@gmail.com",
        age:"35"
        
    },
    {
        id: 2,
        username:"raju",
        img:"https://images.pexels.com/photos/20374737/pexels-photo-20374737/free-photo-of-young-woman-in-a-brown-coat-standing-on-a-snowy-field.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        status:"pending",
        email:"1snw@gmail.com",
        age:"35"
        
    },
    {
        id: 3,
        username:"manu",
        img:"https://images.pexels.com/photos/20374737/pexels-photo-20374737/free-photo-of-young-woman-in-a-brown-coat-standing-on-a-snowy-field.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        status:"passive",
        email:"1snw@gmail.com",
        age:"35"
        
    },
    {
        id: 4,
        username:"jithu",
        img:"https://images.pexels.com/photos/20374737/pexels-photo-20374737/free-photo-of-young-woman-in-a-brown-coat-standing-on-a-snowy-field.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        status:"active",
        email:"1snw@gmail.com",
        age:"35"
        
    },
    {
        id: 5,
        username:"abi",
        img:"https://images.pexels.com/photos/20374737/pexels-photo-20374737/free-photo-of-young-woman-in-a-brown-coat-standing-on-a-snowy-field.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        status:"pending",
        email:"1snw@gmail.com",
        age:"35"
        
    },
    {
        id: 6,
        username:"gopu",
        img:"https://images.pexels.com/photos/20374737/pexels-photo-20374737/free-photo-of-young-woman-in-a-brown-coat-standing-on-a-snowy-field.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        status:"active",
        email:"1snw@gmail.com",
        age:"35"
        
    },
    {
        id: 7,
        username:"vinu",
        img:"https://images.pexels.com/photos/20374737/pexels-photo-20374737/free-photo-of-young-woman-in-a-brown-coat-standing-on-a-snowy-field.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        status:"passive",
        email:"1snw@gmail.com",
        age:"35"
        
    },
    
]