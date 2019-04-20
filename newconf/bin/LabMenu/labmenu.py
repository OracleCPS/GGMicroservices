import json
import tkinter as tk
from tkinter import ttk, font, messagebox
from pprint import pprint
import argparse
import subprocess

debug=0
simulation=0

class LabMenu(tk.Frame):
    def __init__(self, parent):
        """
        Initialize the Lab Selection window.
        :param parent: The parent Tkinter window
        """
        self.parent = parent
        self.labconf = self.get_conf(args.conf)

        self.parent.title("Lab Menu")
        self.numlabs = len(self.labconf["labs"])
        self.radioGroup = ttk.LabelFrame(self.parent, text="Lab Options")
        self.radioGroup.grid(row=0, columnspan=4)

        self.labSelection = tk.IntVar()

        lab_radio = []

        for num in range(self.numlabs):
            labname = 'Lab {}:  {}'.format(self.labconf["labs"][num]["id"], self.labconf["labs"][num]["title"])
            if debug:
                print("Labname is %s, num is %s" % (labname, num))
            lab_radio.append(tk.Radiobutton(self.radioGroup, text=labname, variable=self.labSelection, value=num, bg="gray90")
                                 .grid(sticky='w', row=num+1, column=0))

        self.buttonGroup = ttk.LabelFrame(self.parent, text="Buttons").grid(row=10, columnspan=4)
        self.lab_ok_button = tk.Button(self.buttonGroup, text="Ok", command=self.do_selection)
        self.lab_ok_button.grid(row=11, column=1)
        self.lab_cancel_button = tk.Button(self.buttonGroup, text="Quit", command=self.ask_quit)
        self.lab_cancel_button.grid(row=11, column=2)

    def get_conf(self, conf_file):
        """
        Get the Lab configuration details from the external configuration file.
        :param conf_file: A string of the filepath to the configuration file
        :return: conf: A hierarchical dictionary structure (with arrays) of the configuration
        """
        with open(conf_file) as file:
            conf=json.load(file)
            if debug:
                pprint(conf)
            return conf

    def ask_quit(self):
        """
        Do a graceful exit by asking the user if they would like to quit.
        :return: None
        """
        if tk.messagebox.askyesno("Quit", "Are you sure you want to quit now?"):
            root.destroy()

    def do_selection(self):
        """
        Execute on the chosen Lab Selection and fire off the appropriate scripts.
        :return: None
        """
        if debug:
            print ("Selected array entry %s" % self.labSelection.get())
        print (self.labconf["labs"][self.labSelection.get()]["id"])
        print (self.labconf["labs"][self.labSelection.get()]["title"])
        try:
            print (self.labconf["labs"][self.labSelection.get()]["scripts"])
            for num in range(len(self.labconf["labs"][self.labSelection.get()]["scripts"])):
                try:
                    result = subprocess.run(self.labconf["labs"][self.labSelection.get()]["scripts"][num], shell=True)
                    print (result)
                except subprocess.CalledProcessError as e:
                    print (e.returncode)
                    print (e.stderr)

        except KeyError:
            if debug:
                print ("No script array provided")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Show GoldenGate Lab Menu")
    parser.add_argument("--debug", help="Enable debugging output for troubleshooting", action='store_true')
    parser.add_argument("--simulation", help="Enable simulation mode which provides command execution output but not execution", action='store_true')
    parser.add_argument("--conf", help="Specify path for lab menu configuration")
    args = parser.parse_args()

    if args.debug:
        debug=1

    if args.simulation:
        simulation=1

    root = tk.Tk()
    LabMenu(root)
    root.mainloop()
