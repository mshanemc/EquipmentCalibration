# Equipment Calibration

This repo contains the source and configuration for the equipment calibration tracking application shown in the Lightning Platform 90 Second Apps Video series.

## Part 1 - Create custom objects

Create the Equipment object

1. Setup > Object Manager > Create > Custom Object
2. Use the following values for the Equipment object:
   - Label: Equipment
   - Object Name: Equipment
   - Plural Label: Equipment
   - Record Name: Equipment Name
   - Data Type: Text
   - Allow Reports = Checked
   - Allow Activities = Checked
   - Launch New Custom Tab Wizard after saving this custom object = Checked
3. Click Save.
4. From the New Custom Object Tab page, Click the lookup icon next to **Tab Style** and select the **Hammer** icon.
5. Click Next
6. Select **Apply one tab visibility to all profiles** and ensure the value for **Default On** is displayed
7. Click Next
8. Uncheck the **Include Tab** checkbox at the top of the page.
9. Click Save.

Create the Calibration Event object

1. Return to Setup > Object Manager > Create > Custom Object
2. Use the following values to create the Calibration Event object:
   - Label: Calibration Event
   - Object Name: Calibration_Event
   - Plural Label: Calibration Events
   - Record Name: Calibration Event
   - Data Type: Auto Number
   - Display Format: CE-{000}
   - Starting Number: 1
   - Allow Reports = Checked
   - Allow Activities = Checked
   - Launch New Custom Tab Wizard after saving this custom object = Checked
3. Click Save
4. From the New Custom Object Tab page, Click the lookup icon next to **Tab Style** and select the **Form** icon.
5. Click Next
6. Select **Apply one tab visibility to all profiles** and ensure the value for **Default On** is displayed
7. Click Next
8. Uncheck the **Include Tab** checkbox at the top of the page.
9. Click Save.

## Part 2 - Add Custom Fields

Navigate to Setup > Object Manager > Calibration Event > Fields & Relationships

1. Click New
2. Select **Master-Detail Relationship** for the data type.
3. Click Next
4. Select Equipment from the **Related To** field.
5. Click Next
6. Use the following values for the new field:
   - Field Label: Equipment
   - Field Name: Equipment
   - Child Relationship Name: Calibration_Events
7. Click Next > Next > Next > Save & New to create the field.

Select **Date** for the data type

1. Click Next
2. Use the following values to create the Calibration Date field:
   - Field Label: Calibration Date
   - Field Name: Calibration_Date
3. Click Next > Next > Save & New

Select **Text Area (Rich)**

1. Click Next
2. Use the following values to create the Calibration Notes field:
   - Field Label: Calibration Notes
   - Field Name: Calibration_Notes
3. Click Next > Next > Save & New

Select **Picklist** for the data type.

1. Click Next
2. Use the following values to create the Performed By field:
   - Field Label: Performed By
   - Field Name: Performed_By
   - Select **Enter values, with each value separated by a new line**
   - Add these values to the box provided (or customize the list to fit your needs)
     - Internal - QA Team
     - External Vendor
3. Click Next > Next > Save.

Navigate to Setup > Object Manager > Equipment > Fields & Relationships

1. Click New
2. Select **Number** for the data type
3. Click Next
4. Use these values to create the Calibration Interval field:
   - Field Label: Calibration Interval
   - Field Name: Calibration_Interval
   - Length: 18
   - Decimal Places: 0
5. Click Next > Next > Save & New

Select **Picklist** for the data type

1. Click Next
2. Use these values to create the Department field:
   - Field Label: Department
   - Field Name: Department
   - Select **Enter values, with each value separated by a new line**
   - Add these values to the box provided (or customize the list to fit your needs)
     - Shipping
     - RMA
     - Engineering
3. Click Next > Next > Save & New

Select **Picklist** for the data type

1. Click Next
2. Use these values to create the Equipment Type field:
   - Field Label: Equipment Type
   - Field Name: Equipment_Type
   - Select **Enter values, with each value separated by a new line**
   - Add these values to the box provided (or customize the list to fit your needs)
     - Digital Scale
     - Calipers
     - Oscilloscope
     - Digital Multimeter
3. Click Next > Next > Save & New

Select **Picklist** for the data type

1. Click Next
2. Use these values to create the Status field:
   - Field Label: Status
   - Field Name: Status
   - Select **Enter values, with each value separated by a new line**
   - Add these values to the box provided (or customize the list to fit your needs)
     - Calibration Valid
     - Calibration Due
     - Inactive
3. Click Next > Next > Save & New

Select **Text** for the data type

1. Click Next
2. Use these values to create the Serial Number field:
   - Field Label: Serial Number
   - Field Name: Serial_Number
   - Length: 255
3. Click Next > Next > Save & New

Select **Roll-Up Summary**

1. Click Next
2. Use these values to create the **Last Calibration Date** field:
   - Field Label: Last Calibration Date
   - Field Name: Last_Calibration_Date
3. Click Next
4. Select **Calibration Events** from the list of Summarized Objects
5. Select **Max** for Roll-up Type
6. Select **Calibration Date** from the Field to Aggregate picklist.
7. Ensure that **All records should be included in this calculation**
8. Click Next > Next > Save & New

Select Formula

1.  Click Next
2.  Use these values to create the **Next Due Date** field:
    - Field Label: Next Due Date
    - Field Name: Next_Due_Date
    - Formula Return Type: Date
3.  Click Next
4.  Use this value for the box on the Enter Formula Screen:

    ```
    IF(NOT(ISBLANK(Last_Calibration_Date__c)) && NOT(ISBLANK(Calibration_Interval__c)),    (Last_Calibration_Date__c + Calibration_Interval__c), NULL)
    ```

5.  Click Next > Next > Save & New

Select Formula

1.  Click Next
2.  Use these values to create the **Days Until Next Calibration** field:
    - Field Label: Days Until Next Calibration
    - Field Name: Days_Until_Next_Calibration
    - Formula Return Type: Number
    - Decimal Places: 0
3.  Click Next
4.  Use this value for the box on the Enter Formula Screen:
    `IF( Next_Due_Date__c >= TODAY(), Next_Due_Date__c - TODAY(), 0)`
5.  Click Next > Next > Save`

Create a quick action for entering new calibration events

1. Navigate to Setup > Object Manager > Equipment > Buttons, Links, and Actions
2. Click New Action
3. Action Type: Create Record
4. Target Object: Calibration Event
5. Label: Add Calibration Event
6. Name: Add_Calibration_Event
7. Click Save.
8. Add the fields Equipment, Calibration Date, Performed By, and Calibration Notes to the page layout.
9. Click Save

## Part 3 - Add Automation and Notifications

Create a Custom Notification Type

1. Navigate to Setup > Setup Home > Platform Tools> Notification Builder > Notification Types
2. Click New
3. Use these values to create a new notification type:
   - Custom Notification Name: Internal Notice
   - API Name: Internal_Notice
   - Supported Channels: Desktop & Mobile
4. Click Save

Create an Email Template

1. Navigate to Setup Home > Administration > Email > Classic Email Templates
2. Select **Unfiled Public Classic Email Templates** from the folder list.
3. Click New
4. Select **Text**
5. Click Next
6. Use these values for the new template:
   - Available for Use: Checked
   - Email Template Name: Calibration Due - 7 Day Alert
   - Template Unique Name: Calibration_Due_7_Day_Alert
   - Subject: Equipment Calibration Reminder
   - Body:

```
Notice -
Calibration for equipment {!Equipment__c.Name} is due on {!Equipment__c.Next_Due_Date__c}.
Please update the equipment status using the link below.

{!Equipment__c.Link}
```

7. Click Save

Create an Email Alert

1. Navigate to Setup Home > Platform Tools > Process Automation > Workflow Actions > Email Alerts.
2. Click **New Email Alert**
3. Use the following values to create the new alert:
   - Description: Calibration Due - 7 Day Notice
   - Unique Name: Calibration_Due_7_Day_Notice
   - Object: Equipment
   - Email Template:Calibration Due - 7 Day Alert
   - Recipient Type:Owner
   - Recipients: Select **Equipment Owner** from the **Available Recipients** and use the right arrow to add this option to **Selected Recipients**.
4. Click Save.

Create a Process to manage record changes and alert notifications

1. Navigate to Setup Home > Platform Tools > Process Automation > Process Builder
2. Click **New**
3. Use these values for the fields on the **New Process** screen
   - Process Name: Equipment Calibration Management
   - API Name: Equipment_Calibration_Management
   - The process starts when: A record changes
4. Click Save to create the process.
5. Click the **+ Add Object** box under the start menu
6. Select **Equipment** from the Object list
7. Under **Start the process**, select **when a record is created or edited**
8. Click Save.
9. Click **+ Add Criteria**
10. Enter the following values:
    - Criteria Name: Calibration Values Changed
    - Criteria for Execution: Conditions are met
    - Set Conditions:
      - Item 1:
        - Field: `Equiment__c.Next_Due_Date__c`
        - Operator: Is Null
        - Type: Boolean
        - Value: False
      - Item 2:
        - Field: `Equiment__c.Next_Due_Date__c`
        - Operator: Greater than or equal to
        - Type: Formula
        - Value: Today()
        - Conditions: All of the conditions are met (AND)
        - Advanced: Check Yes.
11. Click Save
12. Click **+ Add Action** under **IMMEDIATE ACTIONS**

Create a Task for the equipment owner

1. Action Type: Create a Record
2. Action Name: Create Task
3. Record Type: Task
4. Set Field Values:

   - Field: Due Date Only

     - Type: Field Reference
     - Value: `[Equipment__c].Next_Due_Date__c`

   - Field: Assigned to Id

     - Type: Field Reference
     - Value:[Equipment__c].OwnerId

   - Field: Priority

     - Type: Picklist
     - Value: Normal

   - Field: Status

     - Type: Picklist
     - Value: Not Started

   - Field: Subject

     - Type: String
     - Value: Equipment Calibration Is Due

   - Field: Related To ID
     - Type: Field Reference
     - Value: [Equipment__c].Id

5. Click Save.

Send a notification to the equipment owner when the due date changes

1. Click **Add Action** under Immediate Actions
2. Action Type: Send Custom Notification
3. Action Name: Send Notice
4. Notification Type: Internal Notice
5. Notification Recipient: Owner [Equipment__c].OwnerId
6. Notification Title: Equipment Calibration Date Change
7. Notification Body:

```
The Next calibration date for {![Equipment__c].Name} has changed to {![Equipment__c].Next_Due_Date__c}
Target Object: Equipment__c Object that started the process.
```

8. Click Save.

Send a 7 day email alert reminder to the equipment owner

1. Click **Set Schedule** under **Scheduled Actions**
2. Set Time for Action to Execute = 7 Days Before Next_Due_Date\_\_c
3. Click **+Add Action** under **Scheduled Actions**
4. Action Type: Email Alerts
5. Action Name: Send 7 Day Notice
6. Email Alert: Calibration_Due_7_Day_Notice
7. Click Save.

Send a 7 day calibration reminder notification to the equipment owner

1. Click **+Add Action** under **Scheduled Actions**
2. Action Type: Send Custom Notification
3. Action Name: Calibration Due 7 Day Notice
4. Notification Type: Internal Notice
5. Notification Recipient: Owner [Equipment__c].OwnerId
6. Notification Title: Equipment Calibration - 7 Day Notice
7. Notification Body:

```
Calibration for equipment {![Equipment__c].Name} is due on {![Equipment__c].Next_Due_Date__c}
Target Object: Equipment__c Object that started the process.
```

8. Click Save.

Add automation to change the status if the equipment isn\*\*t updated on time.

1. Click **Set Schedule** under Schedule Actions.
2. Set Time for Actions to Execute: 1 Days After Next Due Date
3. Click Save.
4. Click **+Add Action** under the new scheduled actions group.
5. Action Type: Update Records
6. Action Name: Set Status to Due
7. Record Type: [Equipment__c]
8. Criteria for Updating Records: No criteria - just update the records!
9. Field: Status
10. Type: Picklist
11. Value: Calibration Due
12. Click Save.
13. Click **Activate** and then Confirm to enable this process.

## Part 4 - Customizing the User Interface

Create a custom Lightning App

1. Navigate to Setup Home > Platform Tools > Apps > App Manager
2. Click **New Lightning App**
3. Enter **Equipment Calibration Management** for App Name
4. Set Developer Name to **Equipment_Calibration_Management**
5. Optionally, assign custom colors for the app.
6. Click Next
7. Use these values for the App Options screen:
   - Navigation Style: Standard Navigation
   - Supported Form Factors: Desktop and Phone
   - Setup Experience: Setup
8. Click Next
9. Click Next on the Utility Items screen
10. Select the following items on the Navigation Items menu:
    - Home
    - Equipment
    - Calibration Events
    - Reports
    - Dashboards
11. Click Next
12. Select **System Administrator** on the User Profiles page.
13. Click Save & Finish

Customize the Equipment detail record page layout

1. Navigate to Setup > Object Manager > Equipment > Page Layouts
2. Open the default **Equipment Layout**
3. Ensure the following fields are included in the Information section of the page layout: Equipment Name, Status, Equipment Type, Owner, Serial Number, Department
4. Add a new section named **Calibration Detail** and add the following fields: Calibration Interval; Next Due Date; Days Until Next Calibration Due; Last Calibration Date
5. Navigate to the **Mobile & Lightning Actions** section at the top of the page and drag the **Add Calibration Event** quick action into the **Salesforce Mobile and Lightning Experience Actions** sections.
6. Ensure that the following related lists are included in the page layout:
   - Calibration Events
   - Open Activities
   - Activity History
7. Click Save to finalize the page layout settings.

Create and Customize a Lightning Record Page for Equipment records

1. Navigate to Setup > Object Manager > Lightning Record Pages
2. Click New
3. Select Record Page
4. Click Next
5. Use these values for Label and Object:
   - Label: Equipment Record Page
   - Object: Equipment
6. Click Next
7. Select **CLONE SALESFORCE DEFAULT PAGE** and select **Grouped View Default**
8. Click Finish.
9. Drag the **Related List - Single** component onto the page and include it under the record detail section. Use the values below to configure this component:
   - Parent Record: Use This Equipment
   - Related List: Calibration Events
   - Related List Type: Enhanced List

Add a calibration due reminder using the rich text component.

1. Add the **Rich Text** component to the top of the right sidebar.
2. Update the value of this item to: **Next Calibration Due in Less Than 7 Days**.
3. Make the text Red and set it in Bold text.
4. Click **+ Add Filter** under **Set Component Visibility**.
5. Select Filter Type: Record Field
   - Field:Days Until Next Calibration
   - Operator: Less Than or Equal
   - Value: 7
6. Click Done.
7. Click **+ Add Filter** again
   - Filter Type: Record Field
   - Field: Days Until Next Calibration
   - Operator: Not Equal
   - Value: 0
8. Click Done
9. Set the value for **Show component when:** to **All filters are true**

Save changes and assign this page to the Equipment Calibration Management Lightning App

1. Click Save at the top of the page.
2. When prompted, select **Activate**
3. Navigate to **App Default** and click **Assign as App Default.**
4. Click the checkbox next to the **Equipment Calibration Management** app
5. Click Next > Next > Save to finalize the changes.

## Step 5 - Create Reports and Dashboards

Create an equipment status report.

1. Navigate to the app launcher > **Equipment Calibration Management** > Reports
2. Click New Report
3. Select Equipment from the Choose Report Type options menu.
4. Click **Continue**
5. Navigate to Filters
6. Set Show Me to **All Equipment**
7. Set Last Calibration Date to **All Time**
8. Click the **Outline** option and add the following fields:
   - Group Rows: Status
   - Columns: Equipment Name,Department, Equipment Type, Serial Number, Last Calibration Date, Days Until Next Calibration
   - Toggle Row Counts and Subtotals to Off
9. Save the report - Name it Equipment By Status
10. Use the **Select Folder** to save this to the **Public Reports** folder.
11. Click Save.

Create an Equipment by Next Due Date report.

1. Click the Reports navigation item to return to the main Reports page.
2. Click **New Report**
3. Select **Equipment** from the **Choose Report Type** options menu.
4. Click Continue
5. Navigate to Filters
6. Set Show Me to **All Equipment**
7. Set Last Calibration Date to **All Time**
8. Click Outline and add the following fields:
   - Group rows: Next Due Date
   - Columns: Equipment Name, Equipment Type, Serial Number, Status
9. Click the down arrow next to **Next Due Date** in the preview window and select > Group Date By > Calendar Month
10. Save the report - name it **Equipment by Next Due Date**
11. Use the **Select Folder** button to save this to the **Public Reports** folder.
12. Click Save.

Create a Calibration History report

1. Click the Reports navigation item to return to the main Reports page.
2. Click **New Report**
3. Select **Equipment with Calibration Events** from the **Choose Report Type** options menu.
4. Click Continue
5. Navigate to Filters
6. Set Show Me to **All Equipment**
7. Set Last Calibration Date to **All Time**
8. Click Outline and add the following fields:
   - Group Rows: Equipment Name
   - Columns: Department, Serial Number, Calibration Event, Calibration Date, Performed By
9. Save this report - name it **Equipment Calibration History**
10. Use the **Select Folder** button to save it in the **Public Reports** folder.
11. Click Save.

Create a Dashboard to show report data

1. Navigate to the **Dashboard** tab
2. Click New Folder
3. Name it **Calibration Dashboard**
4. Click Save.
5. Click **New Dashboard**
6. Name it **Calibration Summary**
7. Select the folder as **Calibration Dashboard**

Add Equipment by Status to the Dashboard.

1. Click **Component**
2. Select **Equipment by Status** from the Recent reports menu.
3. Click Select
4. Select the Pie Chart option from the **Display As** section.
5. Set Value to **Sum of Days Until Next Calibration**
6. Set Sliced By to **Status**
7. Click Save.

Add Equipment by Next Due Date to the Dashboard

1. Click Component
2. Select **Equipment by Status** from the Recent reports menu.
3. Click Select
4. Select the **Bar Chart** option from the **Display As** section
5. Set X-Axis to Next Due Date
6. Set Y-Axis to Record Count
7. Arrange the two components so that they are displayed on the same row of the dashboard.
8. Click Save to update the dashboard.

Create a custom Equipment List view

1. Navigate to the **Equipment** tab.
2. Click the **List View Controls** gear icon and select New
3. Set List Name to **Calibration Due This Week**
4. Set API Name to **Calibration_Due_This_Week**
5. Select **All users can see this list view**
6. Click Save.
7. Click the **List View Controls** gear icon and pick **Select Fields to Display**
8. Add the following items: Equipment Name, Type, Department, Serial Number, Next Due Date, Status
9. Save Changes.
10. Click the **Filter** icon.
11. Set **Filter by Owner** to **All Equipment**
12. Click **Add Filter** and set the options as follows:
    - Field: Next Due Date
    - Operator: Equals
    - Value: THIS WEEK
13. Save the filter changes.

Create a custom home page for the Equipment Calibration Management App

1. Click Setup > Edit Page > Select Pages > New Page
2. Select **Home Page** from the **Create a new Lightning page** menu
3. Click Next
4. Set the Label to **Calibration Home**
5. Click Next
6. Select **Standard Home Page** from the page template selection
7. Click Finish.
8. Drag the **Rich Text** box to the top of the main content page.
9. Set the content of the Rich Text box to **Equipment Calibration Management** to title the page for users.
10. Drag the **Dashboard** component onto the home page just under the **Rich Text** control.
11. With the Dashboard component selected, use the picklist to configure the dashboard to display the **Calibration Summary** build in previous steps.
12. Drag the **List View** component into the right side-bar.
13. Configure the list view options to display the **Task** object
14. Set the Filter to **Open Tasks** and set number of records to display to 10.
15. Drag an additional **List View** component into the right side-bar.
16. Set the object to **Equipment**.
17. Select **Calibration Due this week** for the filter
18. Set number of records to display to 10.
19. Click Save to finalize changes to the home page.
20. Click Activate
21. Select **App Default**
22. Click **Assign to Apps**
23. Select the checkbox next to **Equipment Calibration Management**
24. Click Next > Save.

The app is set-up and ready for you to add equipment and use it to track calibration events. You can test-drive this app by using the link below to create a temporary scratch org with sample data and the configured elements identified above. Once the org is created, click the App Launcher > and select Equipment Calibration.
