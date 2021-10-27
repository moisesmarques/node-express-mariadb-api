const MasterRepository = require('./MasterRepository');
const SlaveRepository = require('./SlaveRepository');

module.exports.insert = async (referral) => {
    await MasterRepository.execute(`
        call insert_referror_fee(?, ?, ?)
    `,[
         referral.userId
        , referral.referredById
        , referral.amount
    ]);
}

module.exports.getSummary = async () => {
    return await SlaveRepository.execute(`
        call get_referror_fee_summary()
    `);
}