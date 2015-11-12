package cms.admin.meeting.solr;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Date;
import java.util.ResourceBundle;
import java.util.Locale;

import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.CommonsHttpSolrServer;
import org.apache.solr.client.solrj.request.ContentStreamUpdateRequest;
import org.apache.solr.client.solrj.request.AbstractUpdateRequest;

public class SolrTools {

	CommonsHttpSolrServer server;
	
	final ResourceBundle rb = ResourceBundle.getBundle ("solr",
            Locale.getDefault ());
	
	String url = rb.getString("solr.url"); 
	//String url = "http://localhost:6020/solr";

	private static SolrTools instance;

	public static synchronized SolrTools getInstance()
			throws MalformedURLException {
		if (instance == null)
			return new SolrTools();
		else
			return instance;
	}

	SolrTools() throws MalformedURLException {

		/*
		 * CommonsHttpSolrServer is thread-safe and if you are using the
		 * following constructor, you *MUST* re-use the same instance for all
		 * requests. If instances are created on the fly, it can cause a
		 * connection leak. The recommended practice is to keep a static
		 * instance of CommonsHttpSolrServer per solr server url and share it
		 * for all requests. See https://issues.apache.org/jira/browse/SOLR-861
		 * for more details
		 */
		server = new CommonsHttpSolrServer(url);

		server.setSoTimeout(1000); // socket read timeout
		server.setConnectionTimeout(100);
		server.setDefaultMaxConnectionsPerHost(100);
		server.setMaxTotalConnections(100);
		server.setFollowRedirects(false); // defaults to false
		// allowCompression defaults to false.
		// Server side must support gzip or deflate for this to have any effect.
		server.setAllowCompression(true);
		server.setMaxRetries(1); // defaults to 0. > 1 not recommended.
	}

	public void addFile(String path, String filename) throws IOException,
			SolrServerException {

		ContentStreamUpdateRequest up = new ContentStreamUpdateRequest(
				"/update/extract");
		up.addFile(new File(path + System.getProperty("file.separator")
				+ filename));
		up.setParam("literal.id", filename);
		up.setAction(AbstractUpdateRequest.ACTION.COMMIT, false, false);
		server.request(up);
	}

	public void addMtgAttcFile(String path, String filename, String agendaId,
			String fileId) throws IOException, SolrServerException {

		ContentStreamUpdateRequest up = new ContentStreamUpdateRequest(
				"/update/extract");
		up.addFile(new File(path + System.getProperty("file.separator")
				+ filename));
		up.setParam("literal.id", agendaId + "_" + fileId);
		up.setParam("literal.agendaid_s", agendaId);
		up.setParam("literal.fileid_s", fileId);
		up.setParam("literal.filename_s", filename);
		up.setParam("literal.date_dt", (new Date()).toString());
		up.setAction(AbstractUpdateRequest.ACTION.COMMIT, false, false);
		server.request(up);
	}
	
	public void addMtgAttcFileDec(String path, String filename, String decisionId,
			String fileId) throws IOException, SolrServerException {

		ContentStreamUpdateRequest up = new ContentStreamUpdateRequest(
				"/update/extract");
		up.addFile(new File(path + System.getProperty("file.separator")
				+ filename));
		up.setParam("literal.id", decisionId + "_" + fileId);
		up.setParam("literal.decisionid_s", decisionId);
		up.setParam("literal.fileid_s", fileId);
		up.setParam("literal.filename_s", filename);
		up.setParam("literal.date_dt", (new Date()).toString());
		up.setAction(AbstractUpdateRequest.ACTION.COMMIT, false, false);
		server.request(up);
	}

	public void delFile(String id) throws SolrServerException, IOException {
		server.deleteById(id);
		server.commit(true, true);
	}
}
