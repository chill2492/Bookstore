<footer>
    <jsp:useBean id="p" scope="request" type="viewmodel.BaseViewModel"/>
    <section id="leftFooter">
        <div id="company">
            <ul class="horizontal">
                <li>&copy; 2018, eBookZone, Inc.</li>
            </ul>
        </div>
    </section>

    <section id="midFooter">
        <div id="contact">
            <ul class="horizontal">
                <li><a href="#"><u>Terms of Use</u></a> |</li>
                <li><a href="#"><u>Privacy Policy</u></a> |</li>
                <li><a href="#"><u>Contact Us</u></a> |</li>
                <li><a href="#"><u>Directions</u></a></li>
            </ul>
        </div>
    </section>

    <section id='rightFooter'>
        <div id="social media">
            <ul class="horizontal">
                <li><a href="#"><img src="${p.siteImagePath}Facebook Logo.png" id="facebookLogo" alt="Facebook Logo"></a></li>
                <li><a href="#"><img src="${p.siteImagePath}Twitter Logo.png" id="twitterLogo" alt="Twitter Logo"></a></li>
            </ul>
        </div>
    </section>

</footer>
