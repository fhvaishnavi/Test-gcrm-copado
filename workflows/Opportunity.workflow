<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ClientOps_Direct_Implementation</fullName>
        <ccEmails>alex.robson@teladochealth.com</ccEmails>
        <description>ClientOps Direct Implementation</description>
        <protected>false</protected>
        <recipients>
            <recipient>alice.yau@teladochealth.com.gcrm</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lfurry@teladochealth.com.gcrm</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ClientOps_Implementations</template>
    </alerts>
    <alerts>
        <fullName>ClientOps_Health_Plans_Implementations</fullName>
        <ccEmails>alex.robson@teladochealth.com</ccEmails>
        <description>ClientOps Health Plans Implementation</description>
        <protected>false</protected>
        <recipients>
            <recipient>agill@teladochealth.com.gcrm</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lfurry@teladochealth.com.gcrm</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ClientOps_Implementations</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Unlock_Email_Alert</fullName>
        <ccEmails>USGHImplementationFullLeadership@teladoc.com</ccEmails>
        <description>Opportunity Unlock Email Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>L2O_Opportunity_Templates/Opportunity_Unlock_Email_Template</template>
    </alerts>
</Workflow>
