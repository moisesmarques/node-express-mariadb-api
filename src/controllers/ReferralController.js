module.exports.build = (app) => {

    const ReferralRepository = require('../repositories/ReferralRepository');
    const UserRepository = require('../repositories/UserRepository');
    const ReferralRequestValidation = require('../validations/ReferralRequestValidation');
    const JwtTokenAuthorizer = require('../services/JwtTokenAuthorizer');

    app.post('/api/v1/referral', async (req, res) => {

        try {

            const authorization = req.headers.authorization;
            const referral = req.body;
            
            if(!authorization){
                res.status(403).json({ message: "Forbidden" });
                return;
            }

            const authorized = await JwtTokenAuthorizer.authorize(authorization);
            if(!authorized){
                res.status(401).json({ message: "Unauthorized" });
                return;
            }

            const errors = ReferralRequestValidation.validate(referral);
            if (errors.length) {
                res.status(400).json({ message: "Invalid parameters", errors: errors });
                return;
            }

            if(await UserRepository.getById(referral.userId) == null)
            {
                res.status(404).json({ message: "User not found" });
                return;
            }

            if(await UserRepository.getById(referral.referredById) == null)
            {
                res.status(404).json({ message: "Referral user not found" });
                return;
            }

            await ReferralRepository.insert(referral);
            res.status(200).json({ message: "Success" });

        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Oops" });
        }

    });

    app.get('/api/v1/referral/summary', async (req, res) => {

        try {

            const authorization = req.headers.authorization;
            
            if(!authorization){
                res.status(403).json({ message: "Forbidden" });
                return;
            }

            const authorized = await JwtTokenAuthorizer.authorize(authorization);
            if(!authorized){
                res.status(401).json({ message: "Unauthorized" });
                return;
            }

            const result = await ReferralRepository.getSummary();
            const fees = result && Array.isArray(result) ? result[0] : [];
            const active = fees.filter( a => a.active == 1).map( item => convertToDTO(item));
            const inactive = fees.filter( a => a.active == 0).map( item => convertToDTO(item));

            res.status(200).json({ message: "Success", data:
            {
                totalFees: fees.map( a => a.amount).reduce( (a, b) => a + b, 0),
                totalReferrals: fees.length,
                active: active,
                inactive: inactive
            } 
        });

        } catch (error) {
            console.log(error);
            res.status(500).json({ message: "Oops" });
        }

    });

    function convertToDTO(item){
        return {
            id: item.id,
            createDate: item.createDate,
            lastModifiedDate: item.lastModifiedDate,
            amount: item.amount,
            user: {
                id: item.id,
                createDate: item.userCreateDate,
                lastModifiedDate: item.userLastModifiedDate,
                userType: item.userType,
                displayName: item.displayName,
                avatarBig: item.avatarBig,
                avatarSmall: item.avatarSmall,
                firstname: item.firstname,
                lastname: item.lastname,
                phoneNumber: item.phoneNumber
            }
        }
    }
}