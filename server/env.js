/** InfluxDB v2 URL */
const url = process.env['INFLUX_URL'] || 'http://192.168.0.188:8086'
/** InfluxDB authorization token */
const token = process.env['INFLUX_TOKEN'] || 'czinWTEvjgorrwNV50JmwsWuYhXfH2x3eqJ73IViyej-g0Fq3Dv-oucgka8ZOuVY5C4-nH9h3fC6WwhYIxkNGQ=='
/** Organization within InfluxDB  */
const org = process.env['INFLUX_ORG'] || 'InternationalProject'
/**InfluxDB bucket used in examples  */
const bucket = 'testing-server'
// ONLY onboarding example
/**InfluxDB user  */
const username = 'casper'
/**InfluxDB password  */
const password = 'casperdk'

export default {
  url,
  token,
  org,
  bucket,
  username,
  password,
}