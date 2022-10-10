package attnets

import (
	"fmt"
)

type Attnets [8]byte

func (v Attnets) ENRKey() string { return "attnets" }

func (v Attnets) String() string {
	return fmt.Sprintf("%x", v[:])
}
