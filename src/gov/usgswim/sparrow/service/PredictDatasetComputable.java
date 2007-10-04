package gov.usgswim.sparrow.service;

import gov.usgswim.task.Computable;
import gov.usgswim.sparrow.PredictionData;
import gov.usgswim.sparrow.util.JDBCUtil;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

/**
 * Task to load a PredictionDataSet from the db.
 * 
 * By implementing Computable, this task can be put in a ComputableCache, which
 * executes the task if the result does not already exist.
 */
public class PredictDatasetComputable implements Computable<Long, PredictionData> {
	protected static Logger log =
		Logger.getLogger(PredictDatasetComputable.class); //logging for this class
		
	public PredictDatasetComputable() {
	}

	public PredictionData compute(Long modelId) throws Exception {
		Connection conn = null;
		PredictionData data = null;
		try {
			conn = SharedApplication.getInstance().getConnection();
			
			long startTime = System.currentTimeMillis();
			log.debug("Begin loading predict data for model #" + modelId);
			
			data = JDBCUtil.loadMinimalPredictDataSet(conn, modelId.intValue());
			
			log.debug("End loading predict data for model #" + modelId + "  Time: " + (System.currentTimeMillis() - startTime) + "ms");
			
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					//ignore
				}
			}
		}
		
		return data;
		
	}
}
