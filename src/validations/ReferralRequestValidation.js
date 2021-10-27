module.exports.validate = (referral) => {

    let errors = [];

    if(referral.userId === undefined || referral.userId === null || referral.userId === '' || referral.userId === 0)
        errors.push("userId is required");

    if(referral.referredById === undefined || referral.referredById === null || referral.referredById === '' || referral.referredById === 0)
        errors.push("referredById is required");

    if(referral.amount === undefined || referral.amount === null || referral.amount === '')
        errors.push("amount is required");

    return errors;

}