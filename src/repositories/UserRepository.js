const SlaveRepository = require('./SlaveRepository');

module.exports.getById = async (id) => {
    const result = await SlaveRepository.execute(`
        SELECT * FROM users WHERE id = ?
    `,[id]);

    return result.length ? result[0] : null;
}